#include <stdio.h>
#include <iostream>
using namespace std;

/*
* Issue #39: �������������� ��������� ������� � int[] � ������� � �������� ��������� �����.
* �����: ������� �����
*/
class IntBytes {
private: 
	
	//�������� �����
	int accurancy;

public:

	//�����������
	IntBytes(int acc){
		accurancy = acc;
	}

	//����������� ������ ���� byte(char) � ������ ���� int
	//����: ������ bytes ���� char, int accuracy = �������� �����, ������ ������� bytes (int)
	//�����: ������ first ���� int

	int* byte_array_in_int(char* bytes, int size) {
		int mod = size % accurancy;
		int count = size / accurancy;
		int i = 0;
		int k = 1;

		int* first;
		if (mod > 0) {
			first = new int [count + 1];
			i = count;
		}
		else {
			first = new int[count];
			i = count - 1;
		}

		for(int j = 0; j <= i; j++) {
			first[j] = 0;
		}

		for(int j = size - 1; j >= 0; j--) {
			int b;
			bytes[j] == '0' ? b = 0 : b = 1;			
			first[i] += (b * pow(2, k - 1));
			if(k == accurancy){
				i--; 
				k = 1;
			}
			else 
				k++;
		}

		return first;
	}

	//����������� ������ int � ������ ���� byte(char)
	//����: ������ ints ���� int, int accuracy = �������� �����, ������ ������� size (int)
	//�����: ������ bytes ���� char,

	char* int_array_in_bytes(int* ints, int size) {
		char* bytes = new char[accurancy * size];
		for(int i = 0; i < size; i++) {
			int k = 0;
			int x = ints[i];
			while(x > 0) {
				x = x / 2;
				k++;
			}			
			if(k > accurancy) return 0;
			for(int j = accurancy - 1; j >= 0; j--) {
				int a = ints[i] % 2;
				a == 0 ? bytes[j + (i * accurancy)] = '0' :  bytes[j + (i * accurancy)] = '1';
				ints[i] = ints[i] / 2;
			}
		}

		return bytes;
	}
};

