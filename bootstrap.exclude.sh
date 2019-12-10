link () {
	echo "Symlink dotfiles to home directory"
	echo "Shall we continue? (y/n)"
	read resp
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
		for file in $( ls -A | grep -vE '\.exclude*|\.git$|.*.md|vscode' ) ; do
			ln -sv "$PWD/$file" "$HOME"
		done
		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

link