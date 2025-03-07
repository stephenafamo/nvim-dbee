package handler

import (
	"github.com/neovim/go-client/msgpack"

	"github.com/kndndrj/nvim-dbee/dbee/core"
)

// callWrap is a wrapper around core.Call with msgpack marshaling capabilities
type callWrap struct {
	call *core.Call
}

func WrapCall(call *core.Call) *callWrap {
	return &callWrap{
		call: call,
	}
}

func WrapCalls(calls []*core.Call) []*callWrap {
	wraps := make([]*callWrap, len(calls))

	for i := range calls {
		wraps[i] = &callWrap{
			call: calls[i],
		}
	}

	return wraps
}

func (cw *callWrap) MarshalMsgPack(enc *msgpack.Encoder) error {
	return enc.Encode(&struct {
		ID        string `msgpack:"id"`
		Query     string `msgpack:"query"`
		State     string `msgpack:"state"`
		TimeTaken int64  `msgpack:"time_taken_us"`
		Timestamp int64  `msgpack:"timestamp_us"`
	}{
		ID:        string(cw.call.GetID()),
		Query:     cw.call.GetQuery(),
		State:     cw.call.GetState().String(),
		TimeTaken: cw.call.GetTimeTaken().Microseconds(),
		Timestamp: cw.call.GetTimestamp().UnixMicro(),
	})
}

// connectionWrap is wrapper around core.Connection with msgpack marshaling capabilities
type connectionWrap struct {
	connection *core.Connection
}

func WrapConnection(connection *core.Connection) *connectionWrap {
	return &connectionWrap{
		connection: connection,
	}
}

func WrapConnections(connections []*core.Connection) []*connectionWrap {
	wraps := make([]*connectionWrap, len(connections))

	for i := range connections {
		wraps[i] = &connectionWrap{
			connection: connections[i],
		}
	}

	return wraps
}

func (cw *connectionWrap) MarshalMsgPack(enc *msgpack.Encoder) error {
	return enc.Encode(&struct {
		ID   string `msgpack:"id"`
		Name string `msgpack:"name"`
		Type string `msgpack:"type"`
		URL  string `msgpack:"url"`
	}{
		ID:   string(cw.connection.GetID()),
		Name: cw.connection.GetName(),
		Type: cw.connection.GetType(),
		URL:  cw.connection.GetURL(),
	})
}

// connectionWrap is wrapper around core.ConnectionParams with msgpack marshaling capabilities
type connectionParamsWrap struct {
	params *core.ConnectionParams
}

func WrapConnectionParams(params *core.ConnectionParams) *connectionParamsWrap {
	return &connectionParamsWrap{
		params: params,
	}
}

func (cw *connectionParamsWrap) MarshalMsgPack(enc *msgpack.Encoder) error {
	return enc.Encode(&struct {
		ID   string `msgpack:"id"`
		Name string `msgpack:"name"`
		Type string `msgpack:"type"`
		URL  string `msgpack:"url"`
	}{
		ID:   string(cw.params.ID),
		Name: cw.params.Name,
		Type: cw.params.Type,
		URL:  cw.params.URL,
	})
}

// structureWrap is a wrapper around core.Structure with msgpack marshaling capabilities
type structureWrap struct {
	structure *core.Structure
}

func WrapStructure(structure *core.Structure) *structureWrap {
	return &structureWrap{
		structure: structure,
	}
}

func WrapStructures(structures []*core.Structure) []*structureWrap {
	wraps := make([]*structureWrap, len(structures))

	for i := range structures {
		wraps[i] = &structureWrap{
			structure: structures[i],
		}
	}

	return wraps
}

func (cw *structureWrap) MarshalMsgPack(enc *msgpack.Encoder) error {
	return enc.Encode(&struct {
		Name     string           `msgpack:"name"`
		Schema   string           `msgpack:"schema"`
		Type     string           `msgpack:"type"`
		Children []*structureWrap `msgpack:"children"`
	}{
		Name:     cw.structure.Name,
		Schema:   cw.structure.Schema,
		Type:     cw.structure.Type.String(),
		Children: WrapStructures(cw.structure.Children),
	})
}
