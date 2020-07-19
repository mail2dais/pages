#!bin/sh

# curl -s https://github.com/mail2dais/pages/blob/master/brewsetup.sh | /bin/bash

brew update

brew install mackup
brew install fd # https://news.mynavi.jp/article/20200626-1069025/
brew install jq
#brew install octave

brew install tree

brew install pyenv
brew install pyenv-virtualenv

brew cask upgrade
brew cask install 4k-video-downloader
brew cask install appcleaner # SmartDeleteをOnにする
brew cask install biscuit
brew cask install cakebrew
brew cask install ccleaner
#brew cask install cd-to-iterm
brew cask install clipy
brew cask install coteditor
brew cask install firealpaca
brew cask install firefox
#brew tap caskroom/fonts
brew cask install freemind
brew cask install g-desktop-suite
brew cask install google-chrome
#brew cask install google-japanese-ime # しばらく「ことえり」を使ってみよう。
brew cask install iina
brew cask install iterm2
brew cask install lastpass
brew cask install macwinzipper
brew cask install messenger
brew cask install monolingual #"Language"から、日本語と英語以外を選択、"Archtecture"から、Intel-64-bitのもの以外を選択し、削除する（それぞれ７９９．３MBと23.8MBの節約）。
brew cask install namechanger
brew cask install onyx
brew cask install p4v
brew cask install qgis
#brew cask install qlcolorcode #しばらく、Glanceを使ってみる。　https://applech2.com/archives/20200520-all-in-one-quick-look-plugin-glance-for-mac.html
#brew cask install qlmarkdown
#brew cask install qlstephen
#brew cask install quicklook-csv # quicklook-csv-jpを使う。
#brew cask install quicklook-json
brew cask install rectangle
brew cask install r
brew cask install rstudio
brew cask install seashore
brew cask install simple-comic
brew cask install skitch
brew cask install sourcetree
brew cask install spotify
brew cask install typora
brew cask install whatsapp
brew cask install the-unarchiver
brew cask install visual-studio-code

brew cask upgrade

brew cleanup
#brew cask cleanup
brew doctor
