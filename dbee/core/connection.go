package core

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/google/uuid"
)

var ErrDatabaseSwitchingNotSupported = errors.New("database switching not supported")

// HelperOptions contain options to be passed to helper methods.
type HelperOptions struct {
	Table           string
	Schema          string
	Materialization StructureType
}

type (
	// Adapter is an object which allows to connect to database using a url.
	// It also has the GetHelpers method, which returns a list of operations for
	// a given type.
	Adapter interface {
		Connect(url string) (Driver, error)
		GetHelpers(opts *HelperOptions) map[string]string
	}

	// Driver is an interface for a specific database driver.
	Driver interface {
		Query(context.Context, string) (ResultStream, error)
		Structure() ([]*Structure, error)
		Close()
	}

	// DatabaseSwitcher is an optional interface for drivers that have database switching capabilities.
	DatabaseSwitcher interface {
		SelectDatabase(string) error
		ListDatabases() (current string, available []string, err error)
	}
)

type ConnectionID string

type Connection struct {
	params           *ConnectionParams
	unexpandedParams *ConnectionParams

	driver  Driver
	adapter Adapter
}

func (s *Connection) MarshalJSON() ([]byte, error) {
	return json.Marshal(s.params)
}

func NewConnection(params *ConnectionParams, adapter Adapter) (*Connection, error) {
	expanded := params.Expand()

	if expanded.ID == "" {
		expanded.ID = ConnectionID(uuid.New().String())
	}

	driver, err := adapter.Connect(expanded.URL)
	if err != nil {
		return nil, fmt.Errorf("adapter.Connect: %w", err)
	}

	c := &Connection{
		params:           expanded,
		unexpandedParams: params,

		driver:  driver,
		adapter: adapter,
	}

	return c, nil
}

func (c *Connection) GetID() ConnectionID {
	return c.params.ID
}

func (c *Connection) GetName() string {
	return c.params.Name
}

func (c *Connection) GetType() string {
	return c.params.Type
}

func (c *Connection) GetURL() string {
	return c.params.URL
}

// GetParams returns the original source for this connection
func (c *Connection) GetParams() *ConnectionParams {
	return c.unexpandedParams
}

func (c *Connection) Execute(query string, onEvent func(*Call)) *Call {
	exec := func(ctx context.Context) (ResultStream, error) {
		return c.driver.Query(ctx, query)
	}

	return newCallFromExecutor(exec, query, onEvent)
}

// SelectDatabase tries to switch to a given database with the used client.
// on error, the switch doesn't happen and the previous connection remains active.
func (c *Connection) SelectDatabase(name string) error {
	switcher, ok := c.driver.(DatabaseSwitcher)
	if !ok {
		return ErrDatabaseSwitchingNotSupported
	}

	err := switcher.SelectDatabase(name)
	if err != nil {
		return fmt.Errorf("switcher.SelectDatabase: %w", err)
	}

	return nil
}

func (c *Connection) ListDatabases() (current string, available []string, err error) {
	switcher, ok := c.driver.(DatabaseSwitcher)
	if !ok {
		return "", nil, ErrDatabaseSwitchingNotSupported
	}

	currentDB, availableDBs, err := switcher.ListDatabases()
	if err != nil {
		return "", nil, fmt.Errorf("switcher.ListDatabases: %w", err)
	}

	return currentDB, availableDBs, nil
}

func (c *Connection) GetStructure() ([]*Structure, error) {
	// structure
	structure, err := c.driver.Structure()
	if err != nil {
		return nil, err
	}

	// fallback to not confuse users
	if len(structure) < 1 {
		structure = []*Structure{
			{
				Name: "no schema to show",
				Type: StructureTypeNone,
			},
		}
	}
	return structure, nil
}

func (c *Connection) GetHelpers(opts *HelperOptions) map[string]string {
	if opts == nil {
		opts = &HelperOptions{}
	}

	helpers := c.adapter.GetHelpers(opts)
	if helpers == nil {
		return make(map[string]string)
	}

	return helpers
}

func (c *Connection) Close() {
	c.driver.Close()
}
