# Macの初期設定

参考サイト
* [Macを買い換えた時の移行作業の方法](https://masafumiiwasaki.com/blog/macbookpro-m1max-unboxing/)
* [Mac を買ったら必ずやっておきたい初期設定 \- Qiita](https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21)

「移行アシスタント」は使うな

# 最初にやること

* 「システム設定」から
  * 「一般」から、ソフトウェア・アップデート
  * ~~「Dock」、「最近使ったアプリケーションをDockに表示」をチェックオフ~~
  * 「Bluetooth」、「Bluetoothをオフにする」
  * 「キーボード」、「キーボード・ショートカット」から「修飾キー」、「Caps Lock」キーを「Control」にする
  * ~~「キーボード」、「テキスト入力」、「入力ソース」、「編集」から、英字入力中にスペルを自動変換をオンにする~~
  * ~~文頭を自動的に大文字にする~~
  * 「日本語 - ローマ字入力」から、「Windows風のキー操作」にして、１度の変換で済むようにする。
  * 「一般」、「情報」から、コンピュータ名を変更する　(e.g.: MacbookAir)
  * 「SiriとSpotlight」、「検索結果」より必要なものだけに絞る
    * Spotlightの検索候補、アプリケーション、フォルダ、計算機、等々

# Finder

「環境設定」から、

* ~~「一般」タブから、「ハードディスク」にチェックする~~
* 「新規Finderウィンドウで次を表示」するから、ホームディレクトリにする
* 「サイドバー」タブから、「最近の項目」と「AirDrop」と「タグ」のチェックを外し、「ホームディレクトリ」にチェック、
* 「詳細」タブから、「すべてのファイル名拡張子を表示」にチェックを入れる

# ターミナル設定

* 「環境設定」から
  * プロファイルは、Proをベースに複製する
  * テキストはアンチエイリアス処理をチェックする
  * フォントはMonaco 12pt

## 隠しファイルを表示する

```shell
$ defaults write com.apple.finder AppleShowAllFiles -boolean true
```

## 共有フォルダで.DS_Storeを作成しない

```shell
$ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
$ killall Finder 
```

## 隠しファイルを削除

* [【Mac】.DS_Storeを一括削除&作らないようにするコマンド](https://kizineko.com/delete-dsstore/)

```shell
find . -name '.DS_Store' -type f -ls -delete
```

* [\.DS\_Storeや\.\_ファイルを削除したい](https://geek-memo.com/delete_exclude/)

`.zshrc`に記載する。

```shell
function delgomi () {
    find $1 \( -name '.DS_Store' -or -name '._*' -or -name 'Thumbs.db' -or -name 'Desktop.ini' \) -delete -print;
}
alias delgomi=delgomi
```


# Homebrew

* [Homebrew](https://brew.sh)

**古いMacでやること**

```shell
$ brew bundle dump --global
$ less ~/.Brewfile
```

**新しいMacでやること**

```shell
$ ls ~/.Brewfile
$ $ brew bundle --global
```

## インストールする項目

```
brew install amazon-photos app-cleaner biscuit claude claude-code codex codex-app coteditor dropbox duplicate-file-finder expressions firefox gemini-cli gitleaks google-chrome graphviz iina keka kiro messenger monolingual mupdf namechanger ollama pre-commit simple-comic smoothcsv spotify sqlfmt sqruff tableplus tmux uv visual-studio-code xz whatsapp zoom
```

qfinder-pro はインストールに失敗した。

# Chrome

## 英辞郎の設定

* [Chromeの検索エンジンの設定を使いこなしていろんなとこから瞬間検索 \- Qiita](https://qiita.com/awakia/items/96cd2181ebbd885ff326)

* 検索エンジン名：ALC
* キーワード：alc 
* http://eow.alc.co.jp/search?q=%s


# AppStore

* [LINE](https://line.me/ja/)

# uv

pyenvからuvに乗り換える。

* [【Python】uvの使い方を忘れたときに見るための早見表](https://zanote.net/python/how-to-use-uv/)

アップデート

```
uv self update
```

cliツールを一時的に使う

```
uv tool run mypy
```

cliツールのインストール

```
uv tool install "shandy-sqlfmt[jinjafmt]"
uv tool list # インストール済みのツール一覧
```

cliツールを一時的に使用する（お試し）。

```
uvx (cli tool name)
uvx pytest
```

nissagaのように本来は `pip install nissaga`のようにインストールするものについて、まずはbrewで探すが、それでも無い場合

```
brew install pipx
pipx install nissaga
```

依存関係を一時的に使用して、Pythonスクリプトを実行する

```
uvx run --with xxx main.py
```

次のコマンドで、プロジェクトを使用することができる。

```
cd
cd workspace
uv init (project-name)
cd (project-name)
```

プロジェクト内のファイル構成は次の通り。

| ファイル名 | 内容 |
| --- | --- |
| .gitignore	| Gitのトラッキング対象外にするファイルを設定 |
| .python-version	| pythonのバージョンを指定 |
| main.py	| プロジェクトのメインファイル |
| pyproject.toml	| プロジェクトの基本設定について記述されている |
| README.md	| READMEファイル |

仮想環境を作成する。
カレント・ディレクトリに、`.venv`フォルダが作成される。

```
#uv venv
```

特定のPythonバージョンで仮想環境を作成することもできる。

```
#uv venv --python 3.10
```

仮想環境の有効化。

```
#source .venv/bin/activate
```

ただし、仮想環境を有効化せずとも、`uv run`で自動的に実行できる。
プロジェクト中のmain.pyを実行するためには、以下のコマンドを使用する。

```
uv run main.py
uv run python main.py
```

パッケージの追加・削除は、自動的に`pyproject.toml`へ反映される。

```
uv add numpy pandas
uv remove numpy
```

手動で編集した場合

```
vi pyproject.toml
uv sync
```

依存関係を一時的に使用する場合

```
uv run --with xxx main.py
```

Pythonのバージョン管理について。

```
uv python find 
uv python list
uv python install 3.11
uv python pin 3.11 # プロジェクトで使うバージョンの固定

uv python uninstall 3.11
```

# Git

* [Mac Git 初期設定](https://qiita.com/ucan-lab/items/aadbedcacbc2ac86a2b3)
* [Mac GitHub SSH接続設定](https://qiita.com/ucan-lab/items/e02f2d3a35f266631f24)

```shell
$ which git
/usr/bin/git

$ git --version
git version 2.24.2 (Apple Git-127)

# ローカルの設定
$ git config -l 
# グローバルの設定
$ git config --global -l

# name/ID
$ git config --global user.name "dais"
$ git config --global user.email "7226738+mail2dais@users.noreply.github.com"

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

## Git初期設定(お好み)

```
# git ファイル名の大文字・小文字の変更を検知する。

$ git config --global core.ignorecase false

# git カラー設定

$ git config --global color.ui true
$ git config --global color.diff auto
$ git config --global color.status auto
$ git config --global color.branch auto

# git 日本語ファイル名をエスケープせずに表示

$ git config --global core.quotepath false

# マージコンフリクトを見やすくする

$ git config --global merge.conflictStyle diff3
```

## 使い方

* [プルリクエストの一連の流れについて](https://qiita.com/kuuuuumiiiii/items/42d2d9ed11e3b29c22cf)
* [【Git】一覧](https://qiita.com/sunstripe2011/items/0b611f6e8a480024dd33)
* [Semantic Commit Messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)

```shell
git clone https://[ホスト名またはIPアドレス]/[グループ]/[リポジトリ].git

git branch -a
git checkout -b　(branch name)
git branch -a

git status

git add (updated file or directory)
git commit -m "comment"
# or
git add .
git commit -m "comment"
# or
git commit -a -m "comment"

git push origin (branch name)

# merge local master first and update remote master
git checkout master
git merge (branch name)
git push origin master
# or you go to Pull Requests page, and merge (and can delete branch on remote, too)
git branch (branch name) --delete
git fetch --prune # project remote status to local

# confirm
git branch -a
```

# npm

* [MacにNode\.jsをインストール \- Qiita](https://qiita.com/kyosuke5_20/items/c5f68fc9d89b84c0df09)

まずはnodebreをインストールする。

```shell
$ brew install nodebrew
$ nodebrew setup
```

そのパス情報を.zshrc に追加する。

次にNode.jsのインストールする。
インストールできるバージョンを確認する。

```shell
$ nodebrew ls-remote

# 最新版をインストール
$ nodebrew install latest

# 安定版をインストール
$ nodebrew install stable
```

使用するバージョンを決める。

```shell
$ nodebrew list
v22.11.0
v22.12.0
v23.2.0

current: none

# 必要なバージョンを有効化する
$ nodebrew use v23.2.0
use v23.2.0
$ node -v
v23.2.0
```

# 最新の .zshrc

```shell
# virtualenvでpromptを変更しない
export VIRTUAL_ENV_DISABLE_PROMPT=1

# prompt settings
autoload -Uz compinit promptinit
compinit
promptinit

# prompt coloring
# https://h2ham.net/zsh-prompt-color/
autoload colors
colors
PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

# delgomi
# https://geek-memo.com/delete_exclude/
function delgomi () {
    find $1 \( -name '.DS_Store' -or -name '._*' -or -name 'Thumbs.db' -or -name 'Desktop.ini' \) -delete -print;
}
#alias delgomi=delgomi

# pip upgrade all
# https://qiita.com/kazushisan/items/183bdeaddf9629a2f21d
#alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"

# pyenv settings
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#export PATH=$HOME/.nodebrew/current/bin:$PATH

# postgresql
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@18/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@18/include"

# mupdf
alias poster-pdf="mutool poster -x 2 -y 2 "

# uv
export PATH="$HOME/.local/bin:$PATH"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dais/.lmstudio/bin"
# End of LM Studio CLI section

# sqlfix
function sqlfix () {
    sqlfmt "$@"
    sqlfluff fix --quiet --ignore parsing "$@"
}

# kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Ollama / Anthropic
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY="" # 重要：空にする
export ANTHROPIC_BASE_URL="http://localhost:11434"
alias claude-q2="claude --model qwen2.5-coder:7b"
alias claude-q3="claude --model qwen3.6:27b" 
alias claude-g="claude --model gemma4:26b"

# bun completions
[ -s "/Users/dais/.bun/_bun" ] && source "/Users/dais/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='/Users/dais/.bun/bin/bun "/Users/dais/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# Added by Antigravity
export PATH="/Users/dais/.antigravity/antigravity/bin:$PATH"

```

# SQL / Database

```shell
$ brew install tableplus
$ wc utf_ken_all.csv
  124436  245076 18348206 utf_ken_all.csv
$ psql -l
$ psql -h localhost -p 5432 -U (OSのユーザ名、dais) -d postgres
psql -h localhost -p 5432 -U dais -d postgres

postgres=# CREATE TABLE zipcode_jp_stg
(
 local_gov_code varchar(5)
 , zipcode_old varchar(5)
 , zipcode varchar(7)
 , prefecture_name_kana varchar
 , city_name_kana varchar
 , town_name_kana varchar
 , prefecture_name_kanji varchar
 , city_name_kanji varchar
 , town_name_kanji varchar
 , hass_multiple_zipcodes_in_town varchar(1)
 , has_multiple_blocks_in_town varchar(1)
 , has_streets_in_town varchar(1)
 , is_multple_towns_per_zipcode varchar(1)
 , update_status varchar(1)
 , correction_reason varchar(1)
);

postgres=# \COPY zipcode_jp_stg FROM '/Users/dais/Downloads/utf_ken_all.csv' DELIMITER ',' CSV;
COPY 124436

postgres=#  SELECT COUNT(*) FROM zipcode_jp_stg;
 count  
--------
 124436
(1 row)

postgres=# SELECT
 zipcode
 , COUNT(*)
FROM zipcode_jp_stg
GROUP BY zipcode
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
 zipcode | count 
---------+-------
 4520961 |    66
 4801103 |    65
 4410302 |    46
 7793405 |    44
 0294205 |    42

postgres=# SELECT
  MAX(LENGTH(prefecture_name_kana))
 , MAX(LENGTH(city_name_kana))
 , MAX(LENGTH(town_name_kana))
 , MAX(LENGTH(prefecture_name_kanji))
 , MAX(LENGTH(city_name_kanji))
 , MAX(LENGTH(town_name_kanji))
FROM zipcode_jp_stg;
 max | max | max | max | max | max 
-----+-----+-----+-----+-----+-----
   6 |  19 | 302 |   4 |  10 | 297

postgres=# CREATE TABLE zipcode_jp_raw
(
 snap_date date
 , local_gov_code varchar(5)
 , zipcode_old varchar(5)
 , zipcode varchar(7)
 , prefecture_name_kana varchar(8)
 , city_name_kana varchar(32)
 , town_name_kana varchar(512)
 , prefecture_name_kanji varchar(8)
 , city_name_kanji varchar(16)
 , town_name_kanji varchar(512)
 , hass_multiple_zipcodes_in_town varchar(1)
 , has_multiple_blocks_in_town varchar(1)
 , has_streets_in_town varchar(1)
 , is_multple_towns_per_zipcode varchar(1)
 , update_status varchar(1)
 , correction_reason varchar(1)
);

postgres=# INSERT INTO zipcode_jp_raw
SELECT '2024-11-30', * FROM zipcode_jp_stg;
```

# 以下は過去

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

## シェル設定

* ~~bashに切り替え~~

```shell
$ chsh -s /bin/bash
```

「デフォルトのシェルはzshにしろ」とメッセージが出るが、これを消すには「~/.bash_profile」に追記する。

```shell
$ echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> ~/.bash_profile
```

## .bashrcと.bash_profileの違い

* [Linux: \.bashrcと\.bash\_profileの違いを今度こそ理解する](https://techracho.bpsinc.jp/hachi8833/2019_06_06/66396)

| 設定ファイル    | 利用法                                                                                                       | 例                                                                 |
|-----------------|--------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| `~/.profile`      | ログイン時にそのセッション全体に適用するものを記述する。シェルの種類に依存しないものを記述する。            | 環境変数、PATH変数 など                                         |
| `~/.bashrc`       | bashでしか使わないものを記述する。対話モードで使うものはすべてここに書く。ここでは何も出力してはならない。 | エイリアス、シェルオプション、EDITOR変数、プロンプト設定 など |
| `~/.bash_profile` | `~/.profile`と同じに使えるが`、bash`のみで有効。余計なものは極力書かない。右の順に読み込むだけにする。           | `~/.profile`があれば読み込む、`~/.bashrc`があれば読む               |

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
* ~~[Back to Back](https://chrome.google.com/webstore/detail/back-to-back/jegdggknidpkiahafcbphabbjcahildm?hl=ja)~~
* [Create Link](https://chrome.google.com/webstore/detail/create-link/gcmghdmnkfdbncmnmlkkglmnnhagajbm?hl=ja)
* Flash Video Downloader
* ~~[HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=ja)~~
* [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=ja)
* ~~[LastPass: Free Password Manager](https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd?hl=ja)~~
* [OneClick Cleaner for Chrome](https://chrome.google.com/webstore/detail/oneclick-cleaner-for-chro/oncckmaelaecccmaniihojgeopkcajfh?hl=ja)_
* ~~[OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall?hl=ja)~~
* [Peek-a-tab](https://chrome.google.com/webstore/detail/peek-a-tab-tabs-manager-f/nnpdamdaknpnohmlbnmgphiodghbohop?hl=ja)
* [PrintWhatYouLike](https://chrome.google.com/webstore/detail/printwhatyoulike/npgfabafajliaooeicdoahbpoajfmbbe?hl=ja)
* ~~[Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=ja)~~
* [Simplify Gmail](https://chrome.google.com/webstore/detail/simplify-gmail/pbmlfaiicoikhdbjagjbglnbfcbcojpj?hl=ja)
* [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=ja)
* ~~Vue.js devtools~~
* ~~Wappalyzer~~
* [その本、図書館にあります。](https://chrome.google.com/webstore/detail/その本、図書館にあります%E3%80%82/ldidobiipljjgfaglokcehmiljadanle?hl=ja)
* [アマゾン注文履歴フィルタ](https://chrome.google.com/webstore/detail/その本、図書館にあります%E3%80%82/ldidobiipljjgfaglokcehmiljadanle?hl=ja)
* ストリームレコーダー
* [自動価格比較／ショッピング検索（Auto Price Checker）](https://chrome.google.com/webstore/detail/自動価格比較%EF%BC%8Fショッピング検索（auto-pric/hafkflejlikjnadiclapppceddoielio?hl=ja)

## Google Mapのアプリ化

ChromeでGoogle Mapを開いたのち、「保存して共有」から「ショートカットを作成」する


# Firefox

* Download Star
* Keepa - Amazon Price Tracker
* LastPass: Free Password Manager
* ~~Simplify Gmail~~
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
 
# それ以外

~* [GoPro Quick](https://gopro.com/ja/jp/shop/softwareandapp/quik-%7C%E2%80%8B-デスクトップをインストール/Quik-Desktop.html)~


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

vueをインストールする。

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

pyenvをインストール済みだが、.zshrc にパスを設定することを忘れずに。
その上で、Global設定していく。ポイントは、pyenvがPythonのバージョンを変えるものだということ。

```
pyenv --version
pyenv --help
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$'
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$' | grep ' 2' | tail -n 1
pyenv install --list | egrep '^[ ]+[23]\.[0-9\.]+$' | grep ' 3' | tail -n 1
pyenv install 3.8.3
pyenv versions
pyenv global 3.8.3

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# pipインストールされているpypyを確認
python -m pip list
# 必要ならpipのアップグレード
pip install --upgrade pip
```

よく使うライブラリは [pypi](https://pypi.org)から探すと良い。
jupyterは、VSCodeでやることが多くなったので、不要かもしれない。

```
pip install black polars tqdm
```

こちらを参考にする。

* [poetry+pyenvでつくるお手軽開発環境](https://zenn.dev/kumamoto/articles/9f0b520020bdd0)
* [pyenv+PoetryでのPython環境構築方法を覚えられない人（私）のための手順書](https://qiita.com/Ryku/items/512a6744bfa9903bf2dd)
* [Pythonのパッケージ管理ツールPoetryを使用する](https://zenn.dev/kkj/articles/d14470babe1930)
* [Poetry × JupyterLabで機械学習環境を整える](https://zenn.dev/colum2131/scraps/1bf61d61a7993e)

```
$ cd ~/workspace
$ mkdir pp-practice
$ cd pp-practice

$ poetry init # poetryプロジェクトを作成する。PythonでCLIツールとか作るPJをやるのなら poetry new でやるのもあり。
$ poetry env use 3.12.2 # poetryに使用するPythonバージョンを教える
Creating virtualenv pp-practice-lzQYAj_F-py3.12 in /Users/dais/Library/Caches/pypoetry/virtualenvs
Using virtualenv: /Users/dais/Library/Caches/pypoetry/virtualenvs/pp-practice-lzQYAj_F-py3.12

$ poetry add polars # Poetryプロジェクトにライブラリを追加する
$ poetry add black
$ poetry add isort
$ poetry add jupyterlab
$ poetry add jupyterlab-code-formatter
$ poetry run jupyter lab

$ touch main.py
$ vi main.py
print('hello world')

$ poetry shell # poetryプロジェクトの仮想環境に入るには
pawning shell within /Users/dais/Library/Caches/pypoetry/virtualenvs/pp-practice-lzQYAj_F-py3.12
dais@MacBook-Air-M3 pp-practice % emulate bash -c '. /Users/dais/Library/Caches/pypoetry/virtualenvs/pp-practice-lzQYAj_F-py3.12/bin/activate'

(pp-practice-py3.12) dais@MacBook-Air-M3 pp-practice % python main.py

(pp-practice-py3.12) dais@MacBook-Air-M3 pp-practice % deactivate # poetryプロジェクトの仮想環境から抜ける

$ poetry run python main.py # 仮想環境の外から実行する（これしか使わない予感）

$ poetry new <プロジェクト名(ディレクトリ名)>
$ cd <プロジェクト名(ディレクトリ名)>
$ poetry add notebook
$ code . # VSCode を開く(ピリオドに注意)

$ poetry env list # 作成済み仮想環境一覧
$ poetry env remove <vertual_env_name> # poetryプロジェクトの仮想環境の削除
```

Jupyter Labを立ち上げたら、SettingsからAdvanced Settings Editorを選択。
SettingsのEdit画面が開くので、menuからJupyterlab Code Formatterを選択。
Edit画面の左側(System Defaults)がシステム側のデフォルト設定、右側(User Preferences)がユーザーの設定になる。
User Preferences側に以下のように記載し、デフォルトで使用したいFormatterを指定する

```
{
    "preferences": {
        "default_formatter": {
            "python": ["black"],
        }
    }
}
```

とはいえ、これらはVisual Studio Code上で設定すべき。

## pyenv

poetryを使うことにしたので、pyenvの設定は不要。

* [MacOSとHomebrewとpyenvで快適python環境を。](https://qiita.com/crankcube/items/15f06b32ec56736fc43a)
* [よく使うPython開発環境構築(仮想環境anyenv、pyenv,pipenv)](https://qiita.com/k4ssyi/items/5ffe9bb82bd1d7b71c25)

いまは[anyenv](https://github.com/anyenv/anyenv)がよりポピュラーみたいだが、不要かな。

他にも、pipではなく、pipenvがポピュラーみたい。でも、個人開発なら不要かも。

* [Pipenvを使ったPython開発まとめ](https://qiita.com/y-tsutsu/items/54c10e0b2c6b565c887a)

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

## pipでインストールするものについて

jupyterlab
jupyterlab-language-pack-ja-JP
polars
