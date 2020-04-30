# Macの初期設定

参考サイト
* [Mac を買ったら必ずやっておきたい初期設定 \- Qiita](https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21)

# 最初にやること

* ソフトウェア・アップデート
* 「システム環境設定」から
  * 「Dock」、「最近使ったアプリケーションをDockに表示」をチェックオフ
  * 「Bluetooth」、「Bluetoothをオフにする」
  * 「キーボード」、「キーボード」タブから「修飾キー」、「Caps Lock」キーを「Control」にする
  * 「キーボード」、「ユーザ辞書」タブから次の3つをチェックオフ
    * 英字入力中にスペルを自動変換
    * 文等を自動的に大文字にする
    * スペースバーを2回押してピリオドを入力
  * 「日付と時刻」、「時計」タブから、「日付を表示」にする。
  * 「共有」、「コンピュータ名」をシンプルな名前にする(e.g.: MacbookAir)
  * 「Spotlight」、「検索結果」より必要なものだけに絞る
    * Spotlightの検索候補、アプリケーション、フォルダ、計算機

# Finder

「環境設定」から、

* 「一般」タブから、「ハードディスク」にチェックする。「新規Finderウィンドウで次を表示」するから、ホームディレクトリにする
* 「サイドバー」タブから、「最近の項目」と「AirDrop」と「タグ」のチェックを外し、「ホームディレクトリ」にチェック、
* 「詳細」タブから、「すべてのファイル名拡張子を表示」にチェック

## LanDiskに接続する

* [MacOS X 10.9 で少し古い LinkStation に AFP で接続する方法](https://align-centre.hatenablog.com/entry/2014/06/10/134954)

```shell
ls com.apple.Apple* # com.apple.AppleShareClient.plistが無いことを確認する
sudo defaults write /Library/Preferences/com.apple.AppleShareClient afp_disabled_uams -array "Cleartxt Passwrd" "MS2.0" "2-Way Randnum exchange"
defaults read /Library/Preferences/com.apple.AppleShareClient afp_disabled_uams
```

次が表示されたらOK

```
(
    "Cleartxt Passwrd",
    "MS2.0",
    "2-Way Randnum  exchange"
)
```

今後は、Windows Storage Server を搭載した NAS がベスト、のようだ。

他にも。

* [MavericksにしたらNASがおかしい、そんなときの対策](https://news.mynavi.jp/article/osxhack-110/)

# 仮想ディスプレイ

* 「Ctrl + ↑」でMission Controlが開いたら、右上にある「+」で「デスクトップ X」を追加する
* 「システム環境設定」から「キーボード」、「ショートカット」タブ、「デスクトップXへ切り替え」にチェックする
* 「システム環境設定」から「Mission Control」、「最新の使用状況に基づいて操作スペースを自動的に並び替える」のチェックを外す

# ターミナル設定

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

## .bashrcと.bash_profileの違い

* [Linux: \.bashrcと\.bash\_profileの違いを今度こそ理解する](https://techracho.bpsinc.jp/hachi8833/2019_06_06/66396)

| 設定ファイル    | 利用法                                                                                                       | 例                                                                 |
|-----------------|--------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| `~/.profile`      | ログイン時にそのセッション全体に適用するものを記述する。シェルの種類に依存しないものを記述する。            | 環境変数、PATH変数 など                                         |
| `~/.bashrc`       | bashでしか使わないものを記述する。対話モードで使うものはすべてここに書く。ここでは何も出力してはならない。 | エイリアス、シェルオプション、EDITOR変数、プロンプト設定 など |
| `~/.bash_profile` | `~/.profile`と同じに使えるが`、bash`のみで有効。余計なものは極力書かない。右の順に読み込むだけにする。           | `~/.profile`があれば読み込む、`~/.bashrc`があれば読む               |

### 隠しファイルを削除

* [\.DS\_Storeや\.\_ファイルを削除したい](https://geek-memo.com/delete_exclude/)

`.bashrc`に記載する。

```shell
function delgomi () {
    find $1 \( -name '.DS_Store' -or -name '._*' -or -name 'Thumbs.db' -or -name 'Desktop.ini' \) -delete -print;
}
alias delgomi=delgomi
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
brew cask install clipy
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
brew cask install qlcolorcode
brew cask install qlmarkdown
brew cask install qlstephen
#brew cask install quicklook-csv # quicklook-csv-jpを使う。
brew cask install quicklook-json
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

## starship

* https://starship.rs
* [iTerm2とstarshipでterminalとshellをお洒落にしました！ \- Qiita](https://qiita.com/macololidoll/items/1c369217c6203dd479bd)

```shell
brew install starship
echo 'eval "$(starship init bash)"' >> ~/.bash_profile
exec $SHELL -l
 ```
 
 ### starship設定ファイル
 
 ```shell
 mkdir ~/.config
 touch ~/.config/starship.toml
 ```
 
 ```
 # Disable the newline at the start of the prompt
add_newline = false

[character]
symbol = "➜"
error_symbol = "✗"
use_symbol_for_status = true

[directory]
truncate_to_repo = false

[git_branch]
symbol = "🌱 "
truncation_length = 4
truncation_symbol = ""

[time]
disabled = false
format = "🕙[ %T ]"
utc_time_offset = "+9"
 ```
 
# Google Add-on

* [ato-ichinen](https://chrome.google.com/webstore/detail/ato-ichinen/pojaolkbbklmcifckclknpolncdmbaph?hl=ja)
* [AutoPagerize](https://chrome.google.com/webstore/detail/autopagerize/igiofjhpmpihnifddepnpngfjhkfenbp?hl=ja)
* [Adblocker for YouTube](https://chrome.google.com/webstore/detail/adblocker-for-youtube/ldkihpcibakajmpnggbjnehoifnnpebn?hl=ja)
* [Back to Back](https://chrome.google.com/webstore/detail/back-to-back/jegdggknidpkiahafcbphabbjcahildm?hl=ja)
* [Create Link](https://chrome.google.com/webstore/detail/create-link/gcmghdmnkfdbncmnmlkkglmnnhagajbm?hl=ja)
* Flash Video Downloader
* [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=ja)
* [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=ja)
* [LastPass: Free Password Manager](https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd?hl=ja)
* [OneClick Cleaner for Chrome](https://chrome.google.com/webstore/detail/oneclick-cleaner-for-chro/oncckmaelaecccmaniihojgeopkcajfh?hl=ja)_
* [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall?hl=ja)
* [Peek-a-tab](https://chrome.google.com/webstore/detail/peek-a-tab-tabs-manager-f/nnpdamdaknpnohmlbnmgphiodghbohop?hl=ja)
* [PrintWhatYouLike](https://chrome.google.com/webstore/detail/printwhatyoulike/npgfabafajliaooeicdoahbpoajfmbbe?hl=ja)
* [Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=ja)
* [Simplify Gmail](https://chrome.google.com/webstore/detail/simplify-gmail/pbmlfaiicoikhdbjagjbglnbfcbcojpj?hl=ja)
* [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=ja)
* Vue.js devtools
* Wappalyzer
* [その本、図書館にあります。](https://chrome.google.com/webstore/detail/その本、図書館にあります%E3%80%82/ldidobiipljjgfaglokcehmiljadanle?hl=ja)
* [アマゾン注文履歴フィルタ](https://chrome.google.com/webstore/detail/その本、図書館にあります%E3%80%82/ldidobiipljjgfaglokcehmiljadanle?hl=ja)
* ストリームレコーダー
* [自動価格比較／ショッピング検索（Auto Price Checker）](https://chrome.google.com/webstore/detail/自動価格比較%EF%BC%8Fショッピング検索（auto-pric/hafkflejlikjnadiclapppceddoielio?hl=ja)

## 英辞郎の設定

* [Chromeの検索エンジンの設定を使いこなしていろんなとこから瞬間検索 \- Qiita](https://qiita.com/awakia/items/96cd2181ebbd885ff326)

# Firefox

* Download Star
* Keepa - Amazon Price Tracker
* LastPass: Free Password Manager
* Sea Containers
* Simplify Gmail
* Tampermonkey
* Tile Pages WE

# Visual Studio Code

* [【初心者】VSCodeの設定同期エクステンション「Setting Sync」](https://qiita.com/tomokei5634/items/22128efe306ce9bc5682)
  * [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)

* Auto Close Tag
* Auto Rename Tag
* Auto-Open Markdown Preview
* Better Comment
* Better Comments
* Bracket Pair Colorizer 2
* Code Blue
* DotENV
* Dracula Theme
* Evillnspector
* Git History
* indent-rainbow
* Japanese Language Pack for VSC
* Markdown All in One
* Markdown PDF
* Markdown Preview Enhanced
* Markdown TOC
* Markdown+Math
* Material Icon Theme
* Output Colorizer
* PlantUML
* Poor Man's T-SQL Formatter
* Pretttier - Code formatter
* Pyright
* Python
* Rainbow CSV
* Regex Previewer
* Remote - Containers
* Remote - SSH
* Remote - SSH: Editing Configuration Files
* Remote - SSH: Explorer
* Remote - WSL
* Remote Development
* Setting Sync
* Spell Right
* SQLTools - Database tools
* Trailing Spaces
* Vetur
* Visual Studio IntelliCode
* vscode-icons
* テキスト構成くん
 
# AppStore

* [LINE](https://line.me/ja/)

# それ以外

* [GoPro Quick](https://gopro.com/ja/jp/shop/softwareandapp/quik-%7C%E2%80%8B-デスクトップをインストール/Quik-Desktop.html)

# Git

* [Mac Git 初期設定](https://qiita.com/ucan-lab/items/aadbedcacbc2ac86a2b3)

```shell
$ which git
/usr/bin/git

$ git --version
git version 2.24.2 (Apple Git-127)

# ローカルの設定
$ git config -l 
# グローバルの設定
$ git config --global -l

# ディレクトリ、ファイル設定
$ mkdir ~/.ssh
$ touch ~/.ssh/config
$ chmod 700 ~/.ssh
$ chmod 600 ~/.ssh/*

$ vi ~/.ssh/config

Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  ServerAliveInterval 15
  ServerAliveCountMax 30
  AddKeysToAgent yes
  UseKeychain yes
  IdentitiesOnly yes
```

## global .gitignore 設定(推奨)

```shell
$ vi ~/.config/git/ignore
```

```
.DS_Store
```

# iTunesからMusicへ

Catalinaになって、iTunesが廃止されて、Musicになったわけだが、色々と構成が変わった。
具体的には、保存先が`./iTunes`から、`./Music`になったり、
音楽ファイルが`iTunes Music Library.xml`から、`Music Library.musiclibrary`になったり。

そのために必要な事は、

* Musicを「Optionキー」で起動し、希望のパスを選択。私の場合は、NASを指定。
* 「環境設定」から、「ファイル」タブ、「ライブラリへの追加時にファイルを"Music Media"フォルダにコピー」にチェックを入れる
* 「ファイル」から「読み込み」で、過去のiTunesフォルダを指定して読み込む。

これをすると、容量にもよるが、半日から１日かかるだろう。
結果的に、Musicフォルダに、iTunesフォルダから移管された事になるが、二重に容量を取っていることになるので、iTunesフォルダは消して良いだろう。

* [Mac OS Catalina：旧iTunesから「ミュージック」への移行時のトラブルと解決 \| 書き散らしの日々](https://ameblo.jp/aibahiro/entry-12548591606.html)
* [CatalinaにしてiTunesからミュージックなどへの移行で失敗してやったこと \| 人生共有](https://aquarium-goldfish.com/catalina-itunes-music-etc/)

# その他のユーティリティ

* [buntatsu/quicklook\-csv\-jp: A QuickLook plugin for CSV files](https://github.com/buntatsu/quicklook-csv-jp)
