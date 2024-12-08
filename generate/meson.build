project(
  'generate',
  ['c','cpp'],
  default_options: [
            'buildtype=debugoptimized',
            'default_library=static',
            'warning_level=3',
            'c_std=c11',
            'cpp_std=c++17',
        ],
        meson_version: '>=0.52')

add_project_arguments(['-Wmissing-field-initializers',
                       '-Wunused-parameter',
                       '-Wshadow',
                       '-Wpointer-arith',
                       '-Wwrite-strings',
                       '-Winline',
                       '-Wformat-nonliteral',
                       '-Wformat-security',
                       '-Wswitch-default',
                       '-Wundef',
                       '-Wno-cast-align', # we frequently do casts
                       '-Werror=incompatible-pointer-types',
                       '-Werror=implicit-function-declaration'],
                      language: 'c')

add_global_arguments(['-fno-rtti', '-fno-exceptions'], language: 'cpp')


cc = meson.get_compiler('c')

llvm_version = ['>=12', '<16']
# First, attempt to use the shared library.
libllvm = dependency('llvm', version: llvm_version, static: false,
                     method: 'config-tool', include_type:'system',
                     required: false)
if not libllvm.found()
  # Try static libraries.
  libllvm = dependency('llvm', version: llvm_version, static: true,
                       method: 'config-tool', include_type:'system',
                       modules: ['x86', 'aarch64', 'analysis', 'passes'])
endif
add_project_arguments(['-DLL_LLVM_MAJOR='+libllvm.version().split('.')[0]], language: 'cpp')


llvm_config = find_program('llvm-config', required: true)
llvm_libs = run_command(llvm_config, '--libs').stdout().strip().split()
executable(
  'generate',
  'generate.cc',
  dependencies:[libllvm],
  include_directories: '/usr/local/include/polly',
  link_args: llvm_libs)

