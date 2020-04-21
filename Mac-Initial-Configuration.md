# Macの初期設定

## 最初にやること

* ソフトウェア・アップデート

## ターミナル設定

* 設定画面から
  * プロファイルは、Proをベースに複製する
  * テキストはアンチエイリアス処理をチェックする
  * フォントはMonaco

## シェル設定

* bashに切り替え

```shell
$ chsh -s /bin/bash
```

「デフォルトのシェルはzshにしろ」とメッセージが出るが、これを消すには「~/.bash_profile」に追記する。

```shell
$ echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> ~/.bash_profile
```

## 隠しファイルを表示する

```shell
$ defaults write com.apple.finder AppleShowAllFiles -boolean true
```

## 共有フォルダで.DS_Storeを作成しない

```shell
$ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```

## 権限設定

Homebrewでインストールする際に、/user/localのパーミッションエラーが発生することがある。
追加されたユーザーでHomebrewを実行する時などにパーミッションエラーが起きるので、予め権限設定する。

## Xcode Command Line Tools

```shell
$ xcode-select --install
```

## Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap caskroom/cask

brew install mackup
brew install pyenv
brew install pyenv-virtualenv

brew cask install 4k-video-downloader
brew cask install appcleaner
brew cask install biscuit
brew cask install cakebrew
brew cask install ccleaner
brew cask install coteditor
brew cask install firealpaca
brew cask install firefox
brew tap caskroom/fonts
brew cask install freemind
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iina
brew cask install iterm2
brew cask install lastpass
brew cask install macwinzipper
brew cask install messenger
brew cask install monolingual
brew cask install namechanger
brew cask install octave-app
brew cask install onyx
brew cask install rectangle
brew cask install rstudio
brew cask install seashore
brew cask install simple-comic
brew cask install skitch
brew cask install spotify
brew cask install typora
brew cask install whatsapp
brew cask install the-unarchiver
brew cask install visual-studio-code

brew cask install cd-to-iterm

brew cask upgrade
```

## Google Add-on

* ato-ichinen
* AutoPagerize
* Back to Back
* Create Link
* Flash Video Downloader
* HTTPS Everywhere
* Keepa - Amazon Price Tracker
* LastPass: Free Password Manager
* OneClick Cleaner for Chrome
* OneTab
* Peek-a-tab, Tabs Manager for Google Chrome™
* PrintWhatYouLike
* Save to Pocket
* Simplify Gmail
* Tampermonkey
* Vue.js devtools
* Wappalyzer
* その本、図書館にあります。
* アマゾン注文履歴フィルタ
* ストリームレコーダー
* 自動価格比較／ショッピング検索（Auto Price Checker）

## Firefox

* Download Star
* Keepa - Amazon Price Tracker
* LastPass: Free Password Manager
* Sea Containers
* Simplify Gmail
* Tampermonkey
* Tile Pages WE

## Visual Studio Code

* [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
  * https://qiita.com/tomokei5634/items/22128efe306ce9bc5682

## starship

* https://starship.rs
* [iTerm2とstarshipでterminalとshellをお洒落にしました！ \- Qiita](https://qiita.com/macololidoll/items/1c369217c6203dd479bd)

```shell
$ brew install starship
$ echo 'eval "$(starship init bash)"' >> ~/.bash_profile
$ exec $SHELL -l
 ```
 
 ### starship設定ファイル
 
 ```shell
 $ mkdir ~/.config
 $ touch ~/.config/starship.toml
 ```
 
 
