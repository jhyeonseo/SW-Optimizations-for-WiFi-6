#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <xtime_l.h>

#include "parameter.h"
#include "benchmarking.h"

#define TEST_CASE 2
#define TEST_ROUNDS 10

XTime xstart, xstop;
float func_time;

unsigned int initializor_dummy(my_complex* uiParam0, my_complex* uiParam1, my_complex* uiParam2){return 1;}
unsigned int validator_dummy(my_complex* uiParam0, my_complex* uiParam1, my_complex* uiParam2){return 1;}

void make_H(my_complex *input)
{
	int i, j, k;

	for(i = 0; i < NSC; i++)
	{
		for(j = 0; j < NRX; j++)
		{
			for(k = 0; k < NTX; k++)
			{
				input[i * (NRX * NTX) + j * NTX + k].real = rand()%9;
				input[i * (NRX * NTX) + j * NTX + k].img =rand()%9;
			}
		}
	}
}

void qrd_ref(my_complex* H, my_complex* Q, my_complex* R)
{
	int i, j, k, l;
	float sq;

	for(i = 0; i < NSC * NRX * NTX; i++)
	{
		Q[i] = H[i];
	}


	for(i = 0; i < NSC; i++)
	{
		for(j = 0; j < NTX; j++)
		{
			sq = 0;
			// L2 Norm
			for(k = 0; k < NRX; k++)
			{
				sq += Q[i * NTX * NRX + k * NTX + j].real * Q[i * NTX * NRX + k * NTX + j].real
					+ Q[i * NTX * NRX + k * NTX + j].img * Q[i * NTX * NRX + k * NTX + j].img;
			}

			// invert sqrt
			R[i * NTX * NTX + j * NTX + j].real = sqrt(sq);

			// Normalization Column
			for(k = 0; k < NRX; k++)
			{
				Q[i * NTX * NRX + k * NTX + j].real /= R[i * NTX * NTX + j * NTX + j].real;
				Q[i * NTX * NRX + k * NTX + j].img /= R[i * NTX * NTX + j * NTX + j].real;
			}

			if(j < NTX - 1)
			{
				// Compute Row
				for(k = j + 1 ; k < NTX; k++)
				{
					for(l = 0; l < NRX; l++)
					{
						R[i * NTX * NTX + j * NTX + k].real += (Q[i * NTX * NRX + l * NTX + j].real * Q[i * NTX * NRX + l * NTX + k].real
															+ Q[i * NTX * NRX + l * NTX + j].img * Q[i * NTX * NRX + l * NTX + k].img);
						R[i * NTX * NTX + j * NTX + k].img += (Q[i * NTX * NRX + l * NTX + j].real * Q[i * NTX * NRX + l * NTX + k].img
															- Q[i * NTX * NRX + l * NTX + j].img * Q[i * NTX * NRX + l * NTX + k].real);
					}
				}

				// Update Column
				for(k = j + 1; k < NTX; k++)
				{
					for(l = 0; l < NRX; l++)
					{
						Q[i * NTX * NRX + l * NTX + k].real = Q[i * NTX * NRX + l * NTX + k].real
											- (R[i * NTX * NTX + j * NTX + k].real * Q[i * NTX * NRX + l * NTX + j].real
													- R[i * NTX * NTX + j * NTX + k].img * Q[i * NTX * NRX + l * NTX + j].img);
						Q[i * NTX * NRX + l * NTX + k].img = Q[i * NTX * NRX + l * NTX + k].img
											- (R[i * NTX * NTX + j * NTX + k].real * Q[i * NTX * NRX + l * NTX + j].img
													+ R[i * NTX * NTX + j * NTX + k].img * Q[i * NTX * NRX + l * NTX + j].real);
					}
				}
			}
		}
	}

}
void qrd_opt(my_complex* H, my_complex* Q, my_complex* R)
{
	qrd_opt_assembly(H, Q, R);
}
extern void qrd_opt_assembly(my_complex* H, my_complex* Q, my_complex* R);

int main()
{

	xil_printf("\r\n");
	xil_printf("<QR-Decomposition>\r\n");
	xil_printf("No. of Tx Antennas: %d\r\n", NTX);
	xil_printf("No. of Rx Antennas: %d\r\n", NRX);
	xil_printf("No. of subcarriers : %d\r\n", NSC);

	int i, mode_sel, ii = 0;

	BENCHMARK_CASE *pBenchmarkCase;
	BENCHMARK_STATISTICS *pStat;

	my_complex *H_mat = 0;
	my_complex *Q_mat_ref = 0, *R_mat_ref = 0;
	my_complex *Q_mat_opt = 0, *R_mat_opt = 0;


	H_mat = (my_complex*)malloc(sizeof(my_complex) * NRX * NTX * NSC); if (H_mat == NULL) { printf("Memory allocation error\r\n"); };

	Q_mat_ref = (my_complex*)malloc(sizeof(my_complex) * NRX * NTX * NSC); if (Q_mat_ref == NULL) { printf("Memory allocation error\r\n"); };
	// calloc : initialized by 0
	R_mat_ref = (my_complex*)calloc(sizeof(my_complex), NTX * NTX * NSC); if (R_mat_ref == NULL) { printf("Memory allocation error\r\n"); };

	Q_mat_opt = (my_complex*)malloc(sizeof(my_complex) * NRX * NTX * NSC); if (Q_mat_opt == NULL) { printf("Memory allocation error\r\n"); };
	// calloc : initialized by 0
	R_mat_opt = (my_complex*)calloc(sizeof(my_complex), NTX * NTX * NSC); if (R_mat_opt == NULL) { printf("Memory allocation error\r\n"); };

	make_H(H_mat);

	double error = 0;
	double signal = 0;
	double NSRdB = 0;

	double opt_time = 0;
	double ref_time = 0;

	for (mode_sel = 0; mode_sel < _mode; mode_sel++)
	{
		if (mode_sel == 0)
		{
			qrd_ref(H_mat, Q_mat_ref, R_mat_ref);
		}
		else
		{
			qrd_opt(H_mat, Q_mat_opt, R_mat_opt);
		}
	}

	for (ii = 0; ii < NSC * NTX * NTX; ii++) {
		error += pow((R_mat_ref[ii].real - R_mat_opt[ii].real), 2) + pow((R_mat_ref[ii].img - R_mat_opt[ii].img), 2);
				+ pow((Q_mat_ref[ii].real - Q_mat_opt[ii].real), 2) + pow((Q_mat_ref[ii].img - Q_mat_opt[ii].img), 2);

		signal += pow((R_mat_ref[ii].real), 2) + pow((R_mat_ref[ii].img), 2);
				+ pow((Q_mat_ref[ii].real), 2) + pow((Q_mat_ref[ii].img), 2);
	}


	NSRdB = 10 * log10(error / signal);

	printf("\nMeasured Accuracy : NSR(dB) = %0.3f \n", NSRdB);

	BENCHMARK_CASE BenchmarkCases[TEST_CASE] = {
		{"QRD Reference", TEST_ROUNDS, initializor_dummy, qrd_ref,
			{H_mat, Q_mat_ref, R_mat_ref},
			0, validator_dummy
		},
		{"QRD Optimization", TEST_ROUNDS, initializor_dummy, qrd_opt,
			{H_mat, Q_mat_opt, R_mat_opt},
			0, validator_dummy
		}
	};

	Xil_L1DCacheEnable();
	Xil_L2CacheDisable();
	Xil_L1ICacheEnable();


	xil_printf("\r\n");
	xil_printf("-----Benchmarking Start-----\r\n");
	for (i = 0; i < TEST_CASE; i++)
	{
		pBenchmarkCase = &BenchmarkCases[i];
		pStat = &(pBenchmarkCase->stat);
		printf("Case %d: %s\r\n", i, pBenchmarkCase->pName);
		run_benchmark_single(pBenchmarkCase);
		statistics_print(pStat);
		if (i == 0)
			ref_time = pStat->ullMax;
		else
			opt_time = pStat->ullMax;
	}

	xil_printf("----Benchmarking Complete----\r\n");
	xil_printf("\r\n");
	printf("Optimized FFT is x%.2f faster than Reference\r\n", (double)(ref_time/opt_time));
	xil_printf("\r\n");

	free(H_mat);
	free(Q_mat_ref);
	free(R_mat_ref);

	free(Q_mat_opt);
	free(R_mat_opt);

    return 0;
}

