int strncmp(const char *s1, const char *s2, size_t n){
	unsigned int count = 0;
	while (count < n){
		if (s1[count] == s2[count]){
			if (s1[count] == '\0'){ //quit when null-termination found
				return 0;
			}else count++; 
		}else{return s1[count] - s2[count];}
	}	
	return 0;
}
