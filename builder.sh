export PATH=$busybox/bin
for path in $buildInputs; do
  PATH=$PATH:$path/bin
done
eval "$buildCommand"
