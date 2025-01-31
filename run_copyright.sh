

# 1. first find all source files
# 2. remove copywrite
find . -regex '.*\.\(cpp\|hpp\|cu\|c\|h\)' \
  -not -path "*/cpi/*" -not -path "*/cmake-build-debug/*" \
  -not -name "*CLI11.hpp" -not -name "*matplotlibcpp.h" \
  -not -name "*ikd_Tree.cpp" \
  -not -name "*ikd_Tree.h" \
  -exec sed -i '1,/\*\//{ /\/\*/,/\*\//d }' {} \;

# 3. Create copytext file
COPYHEADER="/*
 * MINS: An Open Platform for Multi-Sensor-Aided Inertial Navigation System
 * Copyright (C) 2023 Woosik Lee
 * Copyright (C) 2023 Guoquan Huang
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

"
echo "$COPYHEADER" > /tmp/out_copy


# 4. now append the new header to the files!
find . -regex '.*\.\(cpp\|hpp\|cu\|c\|h\)' \
  -not -path "*/cpi/*" -not -path "*/cmake-build-debug/*" \
  -not -name "*CLI11.hpp" -not -name "*matplotlibcpp.h" \
  -not -name "*ikd_Tree.cpp" \
  -not -name "*ikd_Tree.h" \
  -print0 |
  while IFS= read -r -d '' file; do
    echo $file;
    cat /tmp/out_copy $file > /tmp/out && mv /tmp/out $file
  done



