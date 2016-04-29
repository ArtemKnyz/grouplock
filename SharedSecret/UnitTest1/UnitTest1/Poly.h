/*
����� Poly �������� ��� ����: ������ � �������������� � ������� ����������.
���������� ��� �������: getCoef - ������� ������� ���������� ���������� ������� �� ������ �, getP - ��� ���������� ���� ������� ������������
� ������ Poly
*/
#pragma once
#include <vector>
#include "fraction.h"
#include "tnt.h"

using namespace std;
using namespace TNT;

class Poly {
public:	
	vector<Array2D<int>> coefPtr; // ������ � ����-�� ��������
		int deg; // ������� ��������
		int dim; // ����������� �������- �������
		Poly(vector<Array2D<int>> coef, int n, int dimM) {
			deg = n;
			dim = dimM;
			for (int i = 0; i <= n; i++)
				coefPtr.push_back(coef[i]);
		};
		~Poly() {};

};
// ��������� ����������� ��� �������� 
void getCoef(int dimM, int p, Array2D<int> coefPtr) {
	for (int i = 0; i < dimM; ++i) {
		for (int j = 0; j < dimM; ++j)
			//coefPtr[i][j] = Fraction(rand() % (p - 1) + 1, rand() % (p - 1) + 1);
			coefPtr[i][j] = rand() % (p - 1) + 1;
	}

}
// ��������� ������ ��������
void getP(int n, vector<Array2D<int>>& v, Array2D<int> A, int dimM, int p)
{
	for (int i = 0; i < n; ++i)
	{
		Array2D<int> B(dimM, dimM);
		getCoef(dimM, p, B);
		v.push_back(B);
	}
	v.push_back(A);
}

