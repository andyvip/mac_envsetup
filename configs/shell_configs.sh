#========================================== tools export  =============================================

tools=/Volumes/Work/tools

function export_tools()
{
	if [[ ${1} != "" && ! ${PATH} =~ ${1} && -d ${1} ]]; then
		PATH=${1}:${PATH}
	fi
}

for (( idx = 2; idx < 5; idx++ )); do
	for item in $(find ${tools}/depth${idx} -depth ${idx} -type d -name bin -print0 | sed 's/\\0/ /g'); do
		export_tools ${item}
	done
done

export_tools "/usr/local/sbin"
export_tools "/usr/local/opt/gnu-sed/libexec/gnubin"
export_tools "/Applications/Sublime Text.app/Contents/SharedSupport/bin"

export_tools "${tools}/manual/android/sdk/platform-tools"
export_tools "${tools}/manual/android/sdk/platform-tools/systrace"

unset idx
unset item
unset tools

#======================================== tools config ==================================================

export HOMEBREW_NO_AUTO_UPDATE=true

#======================================== zsh  config  =================================================

#plugins=(git)
ZSH_THEME="af-magic"

#======================================== other config ==================================================

alias ll="ls -alf"

if [[ ${SHELL} == "/bin/bash" ]]; then
	[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi
