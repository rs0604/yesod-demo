#!/bin/bash -e

# Install Stack
curl -sSL https://get.haskellstack.org/ | sh

# Install yesod
stack new yesod-server yesod-mysql

cd yesod-server

# build yesod
stack build yesod-bin cabal-install --install-ghc
stack build

# exec yesod
stack exec -- yesod devel
