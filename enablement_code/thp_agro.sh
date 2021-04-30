echo 0 > /sys/kernel/mm/transparent_hugepage/khugepaged/scan_sleep_millisecs
echo 10 > /sys/kernel/mm/transparent_hugepage/khugepaged/alloc_sleep_millisecs

cat /sys/kernel/mm/transparent_hugepage/khugepaged/scan_sleep_millisecs
cat /sys/kernel/mm/transparent_hugepage/khugepaged/alloc_sleep_millisecs
