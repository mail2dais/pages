# Macの初期設定

参考サイト
* [Mac を買ったら必ずやっておきたい初期設定 \- Qiita](https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21)

# 最初にやること

* ソフトウェア・アップデート
* 「システム環境設定」から
  * 「Dock」、「最近使ったアプリケーションをDockに表示」をチェックオフ
  * 「Bluetooth」、「Bluetoothをオフにする」
  * システム設定、キーボード、キーボード・ショートカットから「修飾キー」、「Caps Lock」キーを「Control」にする
  * ~~「キーボード」、「ユーザ辞書」タブから次の3つをチェックオフ~~
    * 英字入力中にスペルを自動変換
    * 文等を自動的に大文字にする
    * スペースバーを2回押してピリオドを入力
  * ~~「日付と時刻」、「時計」タブから、「日付を表示」にする~~。
  * ~~「共有」、「コンピュータ名」をシンプルな名前にする~~(e.g.: MacbookAir)
    * システム設定、一般、情報、コンピュータ名を変更する
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

* ~~bashに切り替え~~

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
```

あとはShellで、[brewsetup.sh](https://github.com/mail2dais/pages/blob/master/brewsetup.sh)を実行する。

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
* [VSCodeでPython書いてる人はとりあえずこれやっとけ〜 \- Qiita](https://qiita.com/nanato12/items/ddf26487eb30714251c3)
 
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

# vue

* [MacにNode\.jsをインストール \- Qiita](https://qiita.com/kyosuke5_20/items/c5f68fc9d89b84c0df09)

まずはnodebreをインストールする。

```shell
brew install nodebrew
nodebrew -v
```

次にNode.jsのインストールする。
インストールできるバージョンを確認する。

``shell
nodebrew ls-remote
```

が、面倒なので、安定版を入れるようと思うが、その前にディレクトリを作る。

```shell
mkdir -p ~/.nodebrew/src
nodebrew install-binary stable
nodebrew ls
```

インストール直後は`current: none`となっているため、必要なバージョンを有効化する。

```shell
nodebrew use v14.1.0
```

次を`.bash_profile`に追加し、sourceする。

```
export PATH=$HOME/.nodebrew/current/bin:$PATH
```

次にvueをインストールする。

```shell
npm install -g @vue/cli
vue --version

npm install -g @vue/cli-service-global #
```

vueのプロジェクト「vue_test」を作る際には、次の通り。

```shell
cd
cd workspace
vue create vue_test # vue init webpack vue_test
cd vue_test
vue serve (実行したい.vueファイル) # 評価用テストサーバを起動
vue serve (実行したい.vueファイル) --open # 評価用テストサーバを起動し、ブラウザを開く
vue build (実行したい.vueファイル) # バンドル(本番用)実行
```

* [VueCLI3導入とできることまとめ \- Qiita](https://qiita.com/tomo0/items/8dc619cc271f4c69658a)

```
npm install --save vuedraggable
```

# React

VueよりもReactの方が将来性があるような気配。

* [ReactとVueのどちらを選ぶか \- Qiita](https://qiita.com/yoichiwo7/items/236b6535695ea67b4fbe)
* [あらためてReactとVueを比較してみる〔2020年最新版〕 ｜ 25歳で独立したフリーランスエンジニア \-じゃけぇ\- のあれこれ](https://freelance-jak.com/technology/react/2472/)

とりあえず、次を参考にインストールしてみる。Vueのインストール時に、既にnodebrewやNode等を入れているので、手軽。

* [気になるReactをキャッチアップ！Macで手軽に開発環境をつくろう！ \- Qiita](https://qiita.com/turkeyzawa/items/c46f367eaddec3cf3025)

```shell
npm install -g create-react-app
```

これにより、次の一文でフォルダも作れ、ブラウザでデモ・ページも開ける。

```shell
create-react-app react_test
cd react_test
npm start
```

と思ったら、公式サイトでは`npm uninstall -g create-react-app`でアンインストールし、をし、`npx`で入れるようにと。

* [facebook/create\-react\-app: Set up a modern web app by running one command\.](https://github.com/facebook/create-react-app)

```shell
npx create-react-app my-app
cd my-app
npm start
```

# IMIコンポーネントツール

この記事に出会う。

* [経産省発の npm モジュール！住所や電話番号の正規化、ジオコーディングなどができる IMI コンポーネントツールを試した！ \- Geolonia developer's blog](https://blog.geolonia.com/2020/05/29/imi-tools.html)
* [IMI 情報共有基盤 コンポーネントツール](https://info.gbiz.go.jp/tools/imi_tools/)

リンク先にあるtgzファイルをダウンロードし、解凍とインストールする。

が、そもそもだが、PATHが通っていなかった。以下を`.bash_profile`に追加する。

```
export PATH=$HOME/.nodebrew/current/bin:$PATH
```

npmには、ローカルモードとグローバルモードがあり、前者はカレントフォルダに、後者はprefixに、それぞれにあるnode_modulesフォルダにパッケージをインストールする。
グローバルパッケージの場所を確認するため、`npm config list`を実行。この中に、`prefix`があることがわかる。あるいは、`npm config get prefix`でも良い。

```shell
$ npm config list
; cli configs
metrics-registry = "https://registry.npmjs.org/"
scope = ""
user-agent = "npm/6.14.5 node/v14.1.0 darwin x64"

; node bin location = /Users/dais/.nodebrew/node/v14.1.0/bin/node
; cwd = /Users/dais
; HOME = /Users/dais
; "npm config ls -l" to show all defaults.

$ npm config get prefix
/Users/dais/.nodebrew/node/v14.1.0
```

これを踏まえ、グローバルモードでパッケージをインストールするには、`-global`オプションを付与する。

```
curl https://info.gbiz.go.jp/tools/imi_tools/resource/imi-enrichment-address/imi-enrichment-address-2.0.0.tgz -o imi-enrichment-address-2.0.0.tgz
npm install imi-enrichment-address-2.0.0.tgz -global
```

`which imi-enrichment-address`でパスが見つかるはず。

```
/Users/dais/.nodebrew/current/bin/imi-enrichment-address
```

これにより、次のようなCLIができるようになる(README.md参照)。

```
# ヘルプの表示
imi-enrichment-address -h

JSON ファイルの変換
imi-enrichment-address input.json > output.json

# 標準入力からの変換
cat input.json | imi-enrichment-address > output.json

# 文字列からの変換
imi-enrichment-address -s 霞が関2 > output.json
```

また、サーバとして起動することもできる。

```
node node_modules/imi-enrichment-address/bin/server.js 8080
```

グローバルパッケージを確認するには、`npm list -g --depth=0`を実行する。

# Python

こちらを参考にする。

* [MacOSとHomebrewとpyenvで快適python環境を。](https://qiita.com/crankcube/items/15f06b32ec56736fc43a)
* [よく使うPython開発環境構築(仮想環境anyenv、pyenv,pipenv)](https://qiita.com/k4ssyi/items/5ffe9bb82bd1d7b71c25)

が、いまは[anyenv](https://github.com/anyenv/anyenv)がよりポピュラーみたい。知らんけど。

```shell
brew install anyenv
anyenv init
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
exec $SHELL -l
anyenv install --init
anyenv -v
anyenv install -l
```

なんか分からないけども、anyenv-updateプラグインも導入する。

```
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
```

pyenvをインストールする。

```
anyenv install pyenv

# シェルの再起動: bash
exec $SHELL -l
```

ちゃんと動くかを確認し、2系と3系の最新版を確認し、3系の最新版を入れた上で、それを普段使用するPythonに設定する。

```
pyenv --version
pyenv --help
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$'
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$' | grep ' 2' | tail -n 1
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$' | grep ' 3' | tail -n 1
pyenv install 3.8.3
pyenv versions
pyenv global 3.8.3

# pipインストールされているpypyを確認
python -m pip list
# 必要ならpipのアップグレード
pip install --upgrade pip
```

ポイントは、pyenvがPythonのバージョンを変えるものだということ。

どうやら、pipではなく、pipenvがポピュラーみたい。でも、個人開発なら不要かも。

* [Pipenvを使ったPython開発まとめ](https://qiita.com/y-tsutsu/items/54c10e0b2c6b565c887a)

pipを通して入れたのはこちら。

```
pip install requests
pip install beautifulsoup4

brew install tcl-tk ghostscript # camelot の dependency.
pip install camelot-py[cv] # tabula-pyも試したが、Javaが必要になるとのことで、やめた。
```

そのうえで、Pythonでファオルトの仮想環境ツール、venvを使うと良いみたい。
例えば、[Open-Interpreter](https://qiita.com/yanagih/items/466a5560bd771e2b9030)を使う場合だ。

* [pyenv](https://qiita.com/mogom625/items/b1b673f530a05ec6b423)
* [venv](https://qiita.com/fiftystorm36/items/b2fd47cf32c7694adc2e)

```
cd venv
mkdir open-interpreter
cd open-interpreter

pyenv versions
pyenv global 3.11.0
# must be over 3.10.0

python -m venv venv
source venv/bin/activate
pip install open-interpreter

deactivate
pyenv global 3.8.3
```

# Jupyter

```
pip install numpy
pip install scipy
pip install scikit-learn
pip install matplotlib
pip install Pillow
pip install jupyterlab
pip install jupyterlab-language-pack-ja-JP


cd 
cd workspace
mkdir jupyter-notebook
jupyter notebook --notebook-dir=~/workspace/jupyter-notebook
```
