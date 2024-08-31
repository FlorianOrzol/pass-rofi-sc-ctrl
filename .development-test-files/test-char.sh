#!/bin/bash

test="hier sind backsicks: _kkkk_"

out=$(echo "$test" | sed 's/_/\`/g')
echo $out

