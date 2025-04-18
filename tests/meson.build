trees = static_library('trees', files('trees.S'),
                       build_by_default: false,
                       include_directories: libfdt_inc)

dumptrees = executable('dumptrees', files('dumptrees.c'),
                       build_by_default: false,
                       link_with: trees, dependencies: libfdt_dep)

dumptrees_dtb = custom_target(
  'dumptrees',
  command: [dumptrees, meson.current_build_dir()],
  output: [
    'test_tree1.dtb',
    'bad_node_char.dtb',
    'bad_node_format.dtb',
    'bad_prop_char.dtb',
    'ovf_size_strings.dtb',
    'truncated_property.dtb',
    'truncated_string.dtb',
    'truncated_memrsv.dtb',
  ]
)

testutil_dep = declare_dependency(sources: ['testutils.c'], link_with: trees)

tests = [
  'add_subnode_with_nops',
  'addr_size_cells',
  'addr_size_cells2',
  'appendprop1',
  'appendprop2',
  'appendprop_addrrange',
  'boot-cpuid',
  'char_literal',
  'check_full',
  'check_header',
  'check_path',
  'del_node',
  'del_property',
  'dtb_reverse',
  'dtbs_equal_ordered',
  'dtbs_equal_unordered',
  'extra-terminating-null',
  'find_property',
  'fs_tree1',
  'get_alias',
  'get_mem_rsv',
  'get_name',
  'get_path',
  'get_phandle',
  'get_prop_offset',
  'get_next_tag_invalid_prop_len',
  'getprop',
  'incbin',
  'integer-expressions',
  'mangle-layout',
  'move_and_save',
  'node_check_compatible',
  'node_offset_by_compatible',
  'node_offset_by_phandle',
  'node_offset_by_prop_value',
  'nop_node',
  'nop_property',
  'nopulate',
  'notfound',
  'open_pack',
  'overlay',
  'overlay_bad_fixup',
  'parent_offset',
  'path-references',
  'path_offset',
  'path_offset_aliases',
  'phandle_format',
  'property_iterate',
  'propname_escapes',
  'references',
  'relref_merge',
  'root_node',
  'rw_oom',
  'rw_tree1',
  'set_name',
  'setprop',
  'setprop_inplace',
  'sized_cells',
  'string_escapes',
  'stringlist',
  'subnode_iterate',
  'subnode_offset',
  'supernode_atdepth_offset',
  'sw_states',
  'sw_tree1',
  'utilfdt_test',
]

tests += [
  'truncated_memrsv',
  'truncated_property',
  'truncated_string',
]

test_deps = [testutil_dep, util_dep, libfdt_dep]

dl = cc.find_library('dl', required: false)
if dl.found()
  tests += [
    'asm_tree_dump',
    'value-labels',
  ]
  test_deps += [dl]
endif

tests_exe = []
foreach t: tests
  tests_exe += executable(t, files(t + '.c'), dependencies: test_deps, build_by_default: false)
endforeach

run_tests = find_program('run_tests.sh')

env = []
if not py.found()
  env += 'NO_PYTHON=1'
else
  env += [
    'PYTHON=' + py.full_path(),
    'PYTHONPATH=' + meson.project_source_root() / 'pylibfdt',
    'NO_PYTHON=0',
  ]
endif
if not yaml.found()
  env += 'NO_YAML=1'
else
  env += 'NO_YAML=0'
endif

run_test_types = [
  'libfdt',
  'utilfdt',
  'dtc',
  'dtbs_equal',
  'fdtget',
  'fdtput',
  'fdtdump',
  'fdtoverlay'
]
run_test_deps = [
  dtc_tools, dumptrees_dtb, tests_exe
]
if pylibfdt_enabled
  run_test_types += 'pylibfdt'
  run_test_deps += pylibfdt
endif
foreach test_type : run_test_types
  test(
    test_type,
    run_tests,
    args: ['-t', test_type],
    is_parallel: false,
    workdir: meson.current_build_dir(),
    depends: run_test_deps,
    env: env,
    timeout: 1800, # mostly for valgrind
  )
endforeach
