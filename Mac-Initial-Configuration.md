# Macの初期設定

大半は、「[Mac を買ったら必ずやっておきたい初期設定 \- Qiita](https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21)」をベースにしている。

## 最初にやること

* ソフトウェア・アップデート
* 「システム環境設定」から
  * 「Dock」、「最近使ったアプリケーションをDockに表示」をチェックオフ
  * 「Bluetooth」、「Bluetoothをオフにする」
  * 「キーボード」、「キーボード」タブから「修飾キー」、「Caps Lock」キーを「Control」にする
  * 「日付と時刻」、「時計」タブから、「日付を表示」にする。
  * 「共有」、「コンピュータ名」をシンプルな名前にする(e.g.: MacbookAir)
  * 「Spotlight」、「検索結果」より必要なものだけに絞る
    * Spotlightの検索候補、アプリケーション、フォルダ、計算機

## Finder

「環境設定」から、

* 「一般」タブから、「ハードディスク」にチェックする。「新規Finderウィンドウで次を表示」するから、ホームディレクトリにする
* 「サイドバー」タブから、「最近の項目」と「AirDrop」と「タグ」のチェックを外し、「ホームディレクトリ」にチェック、

## 仮想ディスプレイ

* 「Ctrl + ↑」でMission Controlが開いたら、右上にある「+」で「デスクトップ X」を追加する

## ターミナル設定

* 「環境設定」から
  * プロファイルは、Proをベースに複製する
  * テキストはアンチエイリアス処理をチェックする
  * フォントはMonaco 10pt

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

## Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update
brew cask upgrade

brew cask install 4k-video-downloader
brew cask install appcleaner # SmartDeleteをOnにする
brew cask install biscuit
brew cask install cakebrew
brew cask install ccleaner
brew cask install coteditor
brew cask install firealpaca
brew cask install firefox
#brew tap caskroom/fonts
brew cask install freemind
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
brew cask install rectangle
brew cask install r
brew cask install rstudio
brew cask install seashore
brew cask install simple-comic
brew cask install skitch
brew cask install spotify
brew cask install typora
brew cask install whatsapp
brew cask install the-unarchiver
brew cask install visual-studio-code

#brew cask install cd-to-iterm

brew cask upgrade

brew install mackup
#brew install octave

brew install pyenv
brew install pyenv-virtualenv

brew cleanup
#brew cask cleanup
brew doctor
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
 
 
