import sys
import filecmp
import subprocess
import os

# arg1 - bin dir, arg2 - root_dir, arg3 - ctest.output

# 找出path目录下的所有reference_output文件
def list_ref_files(path):
    files = []
    list_dir = os.walk(path)
    #print("path:",path)
    for maindir, subdir, all_file in list_dir:
        for filename in all_file:
            apath = os.path.join(maindir, filename)
            if apath.endswith('.reference_output'):
                files.append(apath)

    return files

# 根据bin文件找到对应的reference_output文件
def get_reference_file(bin_file):
    file_path, file_name = os.path.split(bin_file)
    tmp = file_name.split('.')
    # 得到bin文件的前缀部分
    prefix = tmp[0]
    #print('bin prefix: %s' % prefix)

    files = []
    if (bin_file.find('rv32im') != -1):
        files = list_ref_files(sys.argv[2] + r'/tests/riscv-compliance/riscv-test-suite/rv32im/references')
    elif (bin_file.find('rv32i') != -1):
        files = list_ref_files(sys.argv[2] + r'/tests/riscv-compliance/riscv-test-suite/rv32i/references')
    elif (bin_file.find('rv32Zicsr') != -1):
        files = list_ref_files(sys.argv[2] + r'/tests/riscv-compliance/riscv-test-suite/rv32Zicsr/references')
    elif (bin_file.find('rv32Zifencei') != -1):
        files = list_ref_files(sys.argv[2] + r'/tests/riscv-compliance/riscv-test-suite/rv32Zifencei/references')
    else:
        return None

    #print("files:", files)
    #print("prefix", prefix)

    # 根据bin文件前缀找到对应的reference_output文件
    for file in files:
        if (file.find(prefix) != -1):
            return file

    return None

# 主函数
def main():
    ref_file = get_reference_file(sys.argv[1])
    if (ref_file != None):
        # 如果文件大小不一致，直接报fail
        if (os.path.getsize(sys.argv[3]) != os.path.getsize(ref_file)):
            print('!!! FAIL, size != !!!')
            return
        f1 = open(sys.argv[3])
        f2 = open(ref_file)
        f1_lines = f1.readlines()
        i = 0
        # 逐行比较
        for line in f2.readlines():
            # 只要有一行内容不一样就报fail
            if (f1_lines[i] != line):
                print('!!! FAIL, content != !!!')
                f1.close()
                f2.close()
                return
            i = i + 1
        f1.close()
        f2.close()
        print('### PASS ###')
    else:
        print('No ref file found, please check result by yourself.')

if __name__ == '__main__':
    sys.exit(main())
