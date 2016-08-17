// sodium7.cpp: ���������� ����� ����� ��� ����������� ����������.
//

#include "stdafx.h"
#include "sodium.h"
#include "string"
#include "iostream"
#include "loadbmp.h"
#include "savebmp.h"
#include "encryptBMP.h"
#include "decryptBMP.h"

using namespace std;

int main()
{
	unsigned char nonce[crypto_secretbox_NONCEBYTES];
	unsigned char key[crypto_secretbox_KEYBYTES];
	encryptBMP(
		"D:/pict.bmp",
		nonce,key);

	decryptBMP("D:/encrypt.bmp", nonce, key);

	system("pause");


	return 0;
}

