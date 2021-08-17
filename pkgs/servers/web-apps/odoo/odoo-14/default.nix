{ stdenv, lib, fetchurl, python3Packages, glibcLocales, nodejs, lessc, unzip,
postgresql, withPostgresql ? true, fetchpatch }:
    # python3-pip build-essential wget python3-dev python3-venv \
    # python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev \
    # python3-setuptools
    # node-less libjpeg-dev zlib1g-dev libpq-dev \
    # libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev \
    # liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev

let
  inherit (python3Packages) buildPythonApplication buildPythonPackage fetchPypi libfreetype6-dev libxml2-dev libzip-dev
  libldap2-dev libsasl2-dev libjpeg-dev zlib1g-dev libpq-dev ibxslt1-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev
  liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev gdebi;

in buildPythonApplication rec {
  pname = "odoo-ce";
  version = "14.0";

  src = fetchurl {
    url = "https://download.odoocdn.com/${version}/nightly/src/odoo_${version}.latest.tar.gz";
    sha256 = "1r5qrjj6d9yx3ba5y4s7c6nm58fj44p91xa8wq745vrjbjic1d9n";
  };

  postPatch = ''
    sed -i \
      -e 's@pyldap.*@ldap3@i' \
      requirements.txt
  '';

  buildInputs = [

  ];

  propagatedBuildInputs = with python3Packages; [
    Babel
    chardet
    decorator
    docutils
  #  ebaysdk
    feedparser
    freezegun
    gevent
    greenlet
    html2text
    idna
    jinja2
    libsass
    lxml
    Mako
    mock
  # MarkupSafe
    num2words
    ofxparse
    passlib
    pillow
    polib
    psutil
    psycopg2
    pydot
  # python-ldap
    pypdf2
    pyserial
    python-dateutil
    pytz
    pyusb
    qrcode
    reportlab
    requests
    zeep
    python-stdnum
    vobject
    werkzeug
    XlsxWriter
    xlwt
  ];
  # tests need a postgres database
  doCheck = false;

  meta = with lib; {
    homepage = https://odoo.com;
    description = "Open Source ERP, Community edition,
    origin of pkgs: https://github.com/peterhoeg/nixpkgs/blob/master/pkgs/applications/office/agenda/default.nix";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [];
    platforms = platforms.linux;
  };
}
