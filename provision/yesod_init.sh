#!/bin/sh

# stack のインストール
curl -sSL https://get.haskellstack.org/ | sh

# yesod のインストール
stack new rsyesodserver yesod-mysql
cd rsyesodserver
stack install yesod-bin --install-ghc
stack build

# yesod 起動
stack exec -- yesod devel
