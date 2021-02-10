module vzstd

#flag -D ZSTD_STATIC_LINKING_ONLY
#flag -I @VROOT/zstd/lib
#flag @VROOT/zstd/lib/common/debug.o
#flag @VROOT/zstd/lib/common/entropy_common.o
#flag @VROOT/zstd/lib/common/error_private.o
#flag @VROOT/zstd/lib/common/fse_decompress.o
#flag @VROOT/zstd/lib/common/pool.o
#flag @VROOT/zstd/lib/common/threading.o
#flag @VROOT/zstd/lib/common/xxhash.o
#flag @VROOT/zstd/lib/common/zstd_common.o
#include "zstd.h"

fn C.ZSTD_versionNumber() u32

fn C.ZSTD_isError(err size_t) u32

fn C.ZSTD_getErrorName(err size_t) charptr

fn C.ZSTD_versionString() charptr

pub fn version_string() string {
	return cstring_to_vstring(C.ZSTD_versionString())
}

pub fn version_number() u32 {
	return C.ZSTD_versionNumber()
}

pub fn is_error(err size_t) bool {
	return C.ZSTD_isError(err) != 0
}

pub fn get_error_name(err size_t) string {
	return cstring_to_vstring(C.ZSTD_getErrorName(err))
}
