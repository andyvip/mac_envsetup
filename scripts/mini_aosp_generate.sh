
#==============================================================================
#
# 1.sublime text3阅读aosp源码时，因为aosp代码过于庞大，导致sublime text3搜索跳转卡顿。
# 2.aosp大部分源码，其实是都用不到的，一般只关注art，frameworks目录的东西。
# 3.所以本脚步将aosp经常阅读的代码，建立软链接到新的目录中，用以加快sublime text3搜索跳转。
# 4.用法:./mini_aosp_generate.sh <aosp源码目录> [dst]
#
#==============================================================================

aosp_dir=${1}
mini_aosp_dir=${2}

if [[ $aosp_dir == "" && ! -d $1 ]]; then
	echo "error: aosp源码目录无效！"
	exit
fi

if [[ $mini_aosp_dir == "" && ! -d $2 ]]; then
	mini_aosp_dir=${aosp_dir}_mini
	mkdir -p ${mini_aosp_dir}
fi

aosp_dir=$(cd ${aosp_dir}; pwd)
mini_aosp_dir=$(cd ${mini_aosp_dir}; pwd)

link_map_leve0="art bionic build device frameworks hardware libcore libnativehelper system"
link_map_leve1="external/libdrm external/skia"

function link_dir()
{
	echo "$1 -> $2   \c"
	ln -sf $1  $2
	echo
}

for item in ${link_map_leve0}; do
	link_dir ${aosp_dir}/${item} ${mini_aosp_dir}
done

for item in ${link_map_leve1}; do
	prefix=$(dirname ${item})
	mkdir -p ${mini_aosp_dir}/${prefix}
	link_dir ${aosp_dir}/${item} ${mini_aosp_dir}/${prefix}
done

