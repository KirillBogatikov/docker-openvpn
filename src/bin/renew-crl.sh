#!/bin/sh

url_file=$(find / -type f -name "crl.pem.url")

if [ -f "${url_file}" ]; then
  target_dir=$(dirname "${url_file}")
  target_path="${target_dir}/crl.pem"

  url=$(cat "${url_file}")

  curl "${url}" --output ${target_path}
  echo "Saved new CRL to ${target_path}"
fi
