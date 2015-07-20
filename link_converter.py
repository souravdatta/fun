import re
import sys
import os

LINK_FROM = r'(src|href)="http://learnyousomeerlang.com/' 
LINK_TO = r'\1="'
ENCODING = 'latin-1'


def convert_links(fname):
    file = open(fname, 'rb')
    content = file.read().decode(ENCODING)
    file.close()
    basename = os.path.basename(fname)
    dirname = os.path.dirname(fname)
    nfname = os.path.join(dirname, basename + '_')
    filew = open(nfname, 'wb')
    content = re.sub(
        LINK_FROM,
        LINK_TO, 
        content)
    filew.write(str.encode(content, ENCODING))
    filew.close()
    os.remove(fname)
    os.rename(nfname, fname)

def main():
    start = sys.argv[1]
    if not start:
        start = '.'
    for dp, dn, files in os.walk(start):
        for f in files:
            fname = os.path.join(dp, f)
            print('[converting] ', fname)
            convert_links(fname)


if __name__ == '__main__':
    main()
