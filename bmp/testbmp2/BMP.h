
#pragma pack(push, 1) //������ ������������ � 1 ����, ������� ��������� � ������� ���������� ���������. ����� � ���� �� ����� �������. ����� ����� ��������� ��������� ���� � ������� ���������� ������


typedef struct tagRGBQUAD {

	unsigned char rgbtBlue;      // ������������ B-�������� �����
	unsigned char rgbtGreen;     // ������������ G-�������� �����   
	unsigned char rgbtRed;       // ������������ R-�������� �����      
	//unsigned char  rgbtReserved;
} Color;

typedef struct tagBITMAPFILEHEADER {
	short bfType;                            // ��� �����, ������ ���� BM
	int bfSize;                              // ������ ����� � ������
	short bfReserved1;                       // ����������������� ����
	short bfReserved2;                       // ����������������� ����
	int bfOffBits;                           // �������� �������� ������� ������������ ������ �����.
}BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER {
	int biSize;                           // ������ ���������. (����� 40)
	int biWidth;                          // ������ ����������� � ��������.
	int biHeight;                         // ������ ����������� � ��������.
	short biPlanes;                       // ���������� ����������. (������ ���� 1)
	short biBitCount;                     // ������� ����� � ����� �� �������.
	int biCompression;                    // ��� ������. ���� ���������� �� ������������, �� ���� ����� ��������� 0.
	int biSizeImage;                      // ������ ����������� � ������. ���� ����������� �� �����, �� ����� ����� ���� ������� 0.
	int biXPelsPerMeter;                  // �������������� ���������� (� �������� �� ����).
	int biYPelsPerMeter;                  // ������������ ���������� (� �������� �� ����).
	int biClrUsed;                        // ���������� ������������ ������ ������� �������. ���� �������� ���� ����� 0, �� ������������ ����������� ��������� ���������� ������, ������� ��������� ��������� ���� biBitCount.
	int biClrImportant;                   // ���������� �������� ������. ���������� ����� ������, ����������� ��� ����������� �����������. ���� �������� ���� ����� 0, �� ������������ ��� �����.

}BITMAPINFOHEADER;
#pragma pack(pop)


Color **bitecolor;
char *buf;

void createbmp(BITMAPINFOHEADER bitmapInfoHeader, BITMAPFILEHEADER bitmapFileHeader, Color **bitecolor)
{
	FILE *newfile = fopen("tankresult.bmp", "wb");//���������/������� ����� bmp ����
	//����� � ���� ���������
	fwrite(&bitmapFileHeader, sizeof(BITMAPFILEHEADER), 1, newfile);
	fwrite(&bitmapInfoHeader, sizeof(BITMAPINFOHEADER), 1, newfile);

	buf = (char*)malloc(sizeof(char) * 4); //�����

	//����� � ���� RGB
	for (int i = 0; i < bitmapInfoHeader.biHeight; i++)
	{
		for (int j = 0; j < bitmapInfoHeader.biWidth; j++)
		{
			fwrite(&(bitecolor[i][j]), sizeof(bitecolor[i][j]), 1, newfile);
			if (bitmapInfoHeader.biBitCount == 32) fwrite(&buf, 1, 1, newfile);
		}
		if (bitmapInfoHeader.biBitCount == 24) fwrite(buf, sizeof(char), bitmapInfoHeader.biWidth % 4, newfile);
	}

	//��������� ����
	fclose(newfile);
}

Color** readbmp(BITMAPINFOHEADER bitmapInfoHeader, BITMAPFILEHEADER bitmapFileHeader, FILE *file)
{
	//������� ������ ��������� RGB
	bitecolor = (Color **)malloc(sizeof(Color*) * bitmapInfoHeader.biHeight);
	for (int j = 0; j < bitmapInfoHeader.biHeight; j++)
		bitecolor[j] = (Color *)malloc(sizeof(Color) * bitmapInfoHeader.biWidth);

	buf = (char*)malloc(sizeof(char) * 4);//��� �������� ������ ������ ���������� ������� 4 ���������� ����. � � ���������� ������ �������� �����.

	//������ RGB
	for (int i = 0; i < bitmapInfoHeader.biHeight; i++)
	{
		for (int j = 0; j < bitmapInfoHeader.biWidth; j++)
		{
			fread(&(bitecolor[i][j]), sizeof(bitecolor[i][j]), 1, file);
			if (bitmapInfoHeader.biBitCount == 32) fread(&buf, 1, 1, file);
		}
		if (bitmapInfoHeader.biBitCount == 24) fread(buf, 1, bitmapInfoHeader.biWidth % 4, file);
	}

	return bitecolor;
}