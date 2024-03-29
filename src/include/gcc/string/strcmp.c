int strcmp(const char *s1, const char *s2){
	if (strlen(s1) != strlen(s2))return s2-s1;
	return strncmp(s1, s2, strlen(s1)); 
}
