module main

import vzstd

fn test_version_string() {
	assert vzstd.version_string().len > 0
}

fn test_is_error() {
	assert vzstd.is_error(size_t(-1))
	assert !vzstd.is_error(size_t(1))
	assert !vzstd.is_error(size_t(0))
}

fn test_get_error_name() {
	assert vzstd.get_error_name(size_t(-1)) != ""
	assert vzstd.get_error_name(size_t(0)) == "No error detected"
	assert vzstd.get_error_name(size_t(2)) == "No error detected"
}

fn test_min_max_c_level() {
	assert vzstd.min_c_level() < vzstd.max_c_level()
}
