{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonAtLeast
, pythonOlder
, backports-zoneinfo
, python-dateutil
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "time-machine";
  version = "2.3.1";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "adamchainz";
    repo = pname;
    rev = version;
    sha256 = "1flim8xaa7qglh2b39cf57i8g0kg0707pw3mdkrgh0xjn27bv9bi";
  };

  propagatedBuildInputs = [
    python-dateutil
  #] ++ lib.optionals (pythonOlder "3.9") [
    backports-zoneinfo
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = lib.optionals (pythonAtLeast "3.9") [
    # Assertion Errors related to Africa/Addis_Ababa
    "test_destination_datetime_tzinfo_zoneinfo"
    "test_destination_datetime_tzinfo_zoneinfo_nested"
    "test_move_to_datetime_with_tzinfo_zoneinfo"
  ];

  pythonImportsCheck = [
    "time_machine"
  ];

  meta = with lib; {
    description = "Travel through time in your tests";
    homepage = "https://github.com/adamchainz/time-machine";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
