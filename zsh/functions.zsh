# Update all Python packages installed in a virtual environment.
pip-update() {
	pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U
}

# Extract compressed file
# From https://github.com/xvoland/Extract/blob/master/extract.sh
extract() {
	if [ $# -eq 0 ]; then
		# display usage if no parameters given
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
		echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
	fi
	for n in "$@"; do
		if [ ! -f "$n" ]; then
			echo "'$n' - file doesn't exist"
			return 1
		fi

		case "${n%,}" in
		*.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
			tar zxvf "$n"
			;;
		*.lzma) unlzma ./"$n" ;;
		*.bz2) bunzip2 ./"$n" ;;
		*.cbr | *.rar) unrar x -ad ./"$n" ;;
		*.gz) gunzip ./"$n" ;;
		*.cbz | *.epub | *.zip) unzip ./"$n" ;;
		*.z) uncompress ./"$n" ;;
		*.7z | *.apk | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar | *.vhd)
			7z x ./"$n"
			;;
		*.xz) unxz ./"$n" ;;
		*.exe) cabextract ./"$n" ;;
		*.cpio) cpio -id <./"$n" ;;
		*.cba | *.ace) unace x ./"$n" ;;
		*.zpaq) zpaq x ./"$n" ;;
		*.arc) arc e ./"$n" ;;
		*.cso) ciso 0 ./"$n" ./"$n.iso" &&
			extract "$n.iso" && \rm -f "$n" ;;
		*.zlib) zlib-flate -uncompress <./"$n" >./"$n.tmp" &&
			mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n" ;;
		*.dmg)
			hdiutil mount ./"$n" -mountpoint "./$n.mounted"
			;;
		*.tar.zst) tar -I zstd -xvf ./"$n" ;;
		*.zst) zstd -d ./"$n" ;;
		*)
			echo "extract: '$n' - unknown archive method"
			return 1
			;;
		esac
	done
}

# Update dependencies
update() {
	title "Updating dependencies"
	brew cleanup && brew update && brew upgrade
	title "Updating apps"
	mas upgrade
	title "Updating zsh plugins"
	antidote update
}

# Make a backup of a file
bk() {
	if [[ -z $1 ]]; then
		print "Usage: bk <FILE>"
		return 1
	fi
	local backup_name="${1}_$(date +%s)"
	echo "Backup: ${backup_name}"
	cp -a "$1" "${backup_name}"
}

# Get the content type of an http resource
htmime() {
	if [[ -z $1 ]]; then
		print "Usage: htmime <URL>"
		return 1
	fi
	local mime=$(curl -sIX HEAD $1 | sed -nr "s/Content-Type: (.+)/\1/p")
	echo "$mime"
}

# Display a list of supported colors
lscolors() {
	((cols = $COLUMNS - 4))
	s=$(printf %${cols}s)
	for i in {000..$(tput colors)}; do
		echo -e $i $(
			tput setaf $i
			tput setab $i
		)${s// /=}$(tput op)
	done
}

# Pring public IP
myip() {
	curl -s "http://ipv6-test.com/api/myip.php"
	echo
}

# Print a separator banner, as wide as the terminal
hr() {
	print "${(l:COLUMNS::=:)}"
}

# Print a title with banner separators
title() {
	hr
	echo "$1"
	hr
}

# Decrypt a file with encrypted with OpenSSL AES-256-CBC
decrypt() {
	openssl aes-256-cbc -d -a -in $1 -out $1.new
}

# Encrypt a file with OpenSSL AES-256-CBC
# Security warning: AES-256-CBC does not provide authenticated encryption
# and is vulnerable to padding oracle attacks.
encrypt() {
	openssl aes-256-cbc -a -salt -in $1 -out $1.enc
}

# Prints the weather report
weather() {
	if [ -z "$1" ]; then
		curl -s wttr.in/Montreal | head -n 7
	else
		curl -s wttr.in/$1 | head -n 7
	fi
}

# Checkout git branch/tag interactively with FZF
fco() {
	local tags branches target
	tags=$(
		git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}'
	) || return
	branches=$(
		git branch --all | grep -v HEAD |
			sed "s/.* //" | sed "s#remotes/[^/]*/##" |
			sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}'
	) || return
	target=$(
		(
			echo "$tags"
			echo "$branches"
		) |
			fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2
	) || return
	git checkout $(echo "$target" | awk '{print $2}')
}

# Fixup git commit interactively with FZF
gfix() {
	local fzf=(
		fzf
		--ansi
		--reverse
		--tiebreak=index
		--no-sort
		--bind=ctrl-s:toggle-sort
		--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
	)
	local commit=$(git cherry -v master | $fzf | awk '{print $2}')
	if [[ ! -z "$commit" ]]; then
		git commit --fixup=${commit}
		git rebase --interactive --autosquash ${commit}^
	fi
}

# Browse git commit log interactively with FZF
gl() {
	local g=(
		git log
		--graph
		--format='%C(auto)%h%d %s %C(white)%C(bold)%cr'
		--color=always
		"$@"
	)
	local fzf=(
		fzf
		--ansi
		--reverse
		--tiebreak=index
		--no-sort
		--bind=ctrl-s:toggle-sort
		--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
	)
	$g | $fzf
}

# Clean merged branches
git-clean-branches() {
	git branch --merged | egrep -v "(^\*|main|master|dev)" | xargs git branch -d
}

# Run pytest on changed files
gt() {
	local new_files modified_files
	new_files=$(git status | grep 'new file:' | grep -e '^test_.*.py$' | awk '{print $3}')
	modified_files=$(git status | grep 'modified:' | grep -e 'test_.*.py$' | awk '{print $2}')

	if [[ -z $modified_files ]] && [[ -z $new_files ]]; then
		echo "No modified or new files found"
	fi

	for file in $modified_files $new_files; do
		pytest "${file}"
	done
}

# Prune all Docker containers and images
docker-clean() {
	# Stop all containers
	docker stop $(sudo docker ps -a -q)
	# Delete all containers
	docker rm $(sudo docker ps -a -q)
	# Delete all images
	docker rmi $(sudo docker images -q)
}

# Change gcloud project
gcloud-project() {
	if ! type gcloud &>/dev/null; then
		echo "gcloud not found" >&2
		return 1
	fi
	local current_project=$(gcloud config list project --format "value(core.project)")
	echo "Current project: ${current_project}"
	local proj=$(gcloud projects list | fzf --height 50% --header-lines=1 --reverse --multi --cycle | awk '{print $1}')
	if [[ -n $proj ]]; then
		gcloud config set project $proj
		return $?
	fi
}

# Change kubernetes context
kube-context() {
	if ! type kubectl &>/dev/null; then
		echo "kubectl not found" >&2
		return 1
	fi
	local current_context=$(kubectl config current-context)
	echo "Current context: ${current_context}"
	local context=$(kubectl config get-contexts | fzf --height 50% --header-lines=1 --reverse --multi --cycle | awk '{print $1}')
	if [[ -n $context ]]; then
		kubectl config use-context $context
		return $?
	fi
}
