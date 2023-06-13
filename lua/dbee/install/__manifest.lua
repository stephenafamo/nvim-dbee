-- This file is automatically generated using CI pipeline
-- DO NOT EDIT!
local M = {}

-- Links to binary releases
M.urls = {
  ["android/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_android_amd64/bin/dbee_android_amd64",
  ["android/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_android_arm64/bin/dbee_android_arm64",
  ["darwin/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_darwin_amd64/bin/dbee_darwin_amd64",
  ["darwin/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_darwin_arm64/bin/dbee_darwin_arm64",
  ["dragonfly/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_dragonfly_amd64/bin/dbee_dragonfly_amd64",
  ["freebsd/386"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_freebsd_386/bin/dbee_freebsd_386",
  ["freebsd/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_freebsd_amd64/bin/dbee_freebsd_amd64",
  ["freebsd/arm"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_freebsd_arm/bin/dbee_freebsd_arm",
  ["freebsd/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_freebsd_arm64/bin/dbee_freebsd_arm64",
  ["freebsd/riscv64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_freebsd_riscv64/bin/dbee_freebsd_riscv64",
  ["illumos/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_illumos_amd64/bin/dbee_illumos_amd64",
  ["linux/386"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_386/bin/dbee_linux_386",
  ["linux/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_amd64/bin/dbee_linux_amd64",
  ["linux/arm"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_arm/bin/dbee_linux_arm",
  ["linux/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_arm64/bin/dbee_linux_arm64",
  ["linux/loong64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_loong64/bin/dbee_linux_loong64",
  ["linux/mips64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_mips64/bin/dbee_linux_mips64",
  ["linux/mips64le"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_mips64le/bin/dbee_linux_mips64le",
  ["linux/ppc64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_ppc64/bin/dbee_linux_ppc64",
  ["linux/ppc64le"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_ppc64le/bin/dbee_linux_ppc64le",
  ["linux/riscv64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_riscv64/bin/dbee_linux_riscv64",
  ["linux/s390x"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_linux_s390x/bin/dbee_linux_s390x",
  ["netbsd/386"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_netbsd_386/bin/dbee_netbsd_386",
  ["netbsd/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_netbsd_amd64/bin/dbee_netbsd_amd64",
  ["netbsd/arm"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_netbsd_arm/bin/dbee_netbsd_arm",
  ["netbsd/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_netbsd_arm64/bin/dbee_netbsd_arm64",
  ["openbsd/386"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_openbsd_386/bin/dbee_openbsd_386",
  ["openbsd/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_openbsd_amd64/bin/dbee_openbsd_amd64",
  ["openbsd/arm"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_openbsd_arm/bin/dbee_openbsd_arm",
  ["openbsd/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_openbsd_arm64/bin/dbee_openbsd_arm64",
  ["openbsd/mips64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_openbsd_mips64/bin/dbee_openbsd_mips64",
  ["solaris/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_solaris_amd64/bin/dbee_solaris_amd64",
  ["windows/386"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_windows_386/bin/dbee_windows_386.exe",
  ["windows/amd64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_windows_amd64/bin/dbee_windows_amd64.exe",
  ["windows/arm"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_windows_arm/bin/dbee_windows_arm.exe",
  ["windows/arm64"] = "https://github.com/kndndrj/nvim-dbee-bucket/raw/run-5259358190_windows_arm64/bin/dbee_windows_arm64.exe",
}

-- Current version of go main package
M.version = "a86440a42dd67e8ae558dee5d5b7af5a299b98e5"

return M
