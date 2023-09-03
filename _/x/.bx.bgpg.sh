#.bx.bgpg.sh: brian's gpg
# 20230903_102336

gpg --symmetric --cipher-algo AES256 --digest-algo SHA512 --batch --armor --openpgp --comment "BGPGFile:$(date +%Y%m%d_%H%M%S) by B."
