public static int[][] multiply(int[][] a, int[][] b) throws Exception{
		if(a[0].length != b.length){
			throw new Exception("impossible !");
		}
		int l = (a.length * a[0].length < b.length * b[0].length)?b.length:a.length;
		int c = (a.length * a[0].length < b.length * b[0].length)?b[0].length:a[0].length;
	 
		int[l][c] result;
		 
		 l = 0;
	     for (int i = 0;i < a.length;i++){ 
	    	 c = 0;
            for (int j = 0;j< b[0].length;j++){ 
                int calcul= 0;
                for (int k = 0;k < b.length;k++){  
                    calcul += a[i][k] * b[k][j];
                }
                result[l][c] = calcul;
                c++;
            }
            l++;
	     }
		return result;
	}