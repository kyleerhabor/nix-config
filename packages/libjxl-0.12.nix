{ fetchFromGitHub, libjxl }: libjxl.overrideAttrs (old: {
  version = "0.12.0";
  src = fetchFromGitHub {
    owner = "libjxl";
    repo = "libjxl";
    tag = "v0.12.0";
    hash = "sha256-rJyvJo1ZveE1pvMErK9ilFQA0NXkD2ka93L+1gXeqf8=";
    fetchSubmodules = true;
  };
})
