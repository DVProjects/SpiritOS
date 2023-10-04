;basic lis of file names and where they are located {filename1-sector#, filenam2-sector# , ...}
db "{calculator-4,test-5}"
;fill with 0s IT iS NOT 510 ITS 512
times 512-($-$$) db 0
