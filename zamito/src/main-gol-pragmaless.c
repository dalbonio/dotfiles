#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#define dataset_cols 4
#define end_cols 3
#define end 2

int weights[3] = {1, 1, 1};
int urbanInicial = 0;
double pThreshold = 1.6;

struct Cell_{
	int attrs[dataset_cols];
};
typedef struct Cell_ Cell;

struct stLattice{
		Cell *buff0;
		Cell *buff1;
    int width;
    int height;
    int steps;
};
typedef struct stLattice tpLattice;

void InitRandness(tpLattice *mLattice, float p);
void GameOfLife(tpLattice *mLattice);
void checkRuralAreas(tpLattice *mLattice);
double random();
int main(int ac, char**av)
{
		srand(time(0));
    tpLattice mLattice;
    int flagSave = atoi(av[4]);
    float prob   = atof(av[5]);
		int dataset_rows = sqrt(atoi(av[6]));
		//printf("dataset_rows: %d", dataset_rows);
    //Inicializa variável
    mLattice.width  = dataset_rows;
    mLattice.height = dataset_rows;
    mLattice.steps  = atoi(av[3]);
		int dataset_size = mLattice.width * mLattice.height;

    fprintf(stdout, "Game of life");
    fprintf(stdout, "\nDominio(%d, %d, %d)\nDatasetSize: %d\n",   mLattice.width,   mLattice.height, mLattice.steps, dataset_size);

    fflush(stdout);

    mLattice.buff0 = (Cell*) malloc (dataset_size * sizeof(Cell));
    mLattice.buff1 = (Cell*) malloc (dataset_size * sizeof(Cell));
    InitRandness(&mLattice, prob);

		printf("\nUrban Inicial: %d", urbanInicial);

    for (int t = 0; t < mLattice.steps; t++)
    {
      GameOfLife(&mLattice);
      Cell *swap = mLattice.buff0;
      mLattice.buff0 = mLattice.buff1;
      mLattice.buff1 = swap;
    }

		checkRuralAreas(&mLattice);

    free(mLattice.buff0);
    free(mLattice.buff1);
    return EXIT_SUCCESS;
		
}

/*
 * Função utilizada para iniciar a matriz. Não mudar o valor constante do seed do rand
 */
void InitRandness(tpLattice *mLattice, float p){
//  memset(mLattice->buff0, 0x00,  mLattice->width *   mLattice->height *  sizeof(Cell));
//  memset(mLattice->buff1, 0x00,  mLattice->width *   mLattice->height *  sizeof(Cell));
//  srand (42);
//{
  for (int j = 0; j < mLattice->height; j++){
      for (int i = 0; i < mLattice->width; i++){
          int k = j * mLattice->width + i;
					for(int col = 0; col < dataset_cols; col++){
						fscanf(stdin, "%d", &mLattice->buff0[k].attrs[col]);
						//printf("%d , ", mLattice->buff0[k].attrs[col]);
						mLattice->buff1[k].attrs[col] = mLattice->buff0[k].attrs[col];
					}
					//printf("\n");
					urbanInicial += mLattice->buff0[k].attrs[dataset_cols - 1] & 1;
      }//end-  for (int i = 0; i < mLattice->width; i++){
  }//end-for (int j = 0; j < mLattice->height; j++){
//}//#pragma omp parallel shared(mLattice, p)
}//end-void InitRandness(tpLattice *mLattice, float p){

/*
 * Função que resolve o GOL. Adota-se os chamados pontos fantasmas como condição de contorno, ou seja,
 * os elementos da borda não são alterados em nenhum dos dois buffers.
 * Adota-se zero para esses pontos como valor padrão
 */
void GameOfLife(tpLattice *mLattice){
    Cell nw, n, ne, w, e, sw, s, se, c;
		double psum, pn, p0, pR, p;
		int nb;
		double k = 1;
    /*
        nw | n | ne
       ----|---|----
        w  | c |  e
       ----|---|----
        sw | s | se
    */
    for (int j = 1; j < mLattice->height - 1; j++){
        for (int i = 1; i < mLattice->width - 1; i++){

          nw = mLattice->buff0[(j - 1) * mLattice->width  +  (i - 1)];
           n = mLattice->buff0[(j - 1) * mLattice->width  +  i];
          ne = mLattice->buff0[(j - 1) * mLattice->width  +  (i + 1)];
          w  = mLattice->buff0[j * mLattice->width  +  (i - 1)];
          c  = mLattice->buff0[j * mLattice->width  +  i];
          e  = mLattice->buff0[j * mLattice->width  +  (i + 1)];
          sw = mLattice->buff0[(j + 1) * mLattice->width  +  (i - 1)];
          s  = mLattice->buff0[(j + 1) * mLattice->width  +  i];
          se = mLattice->buff0[(j + 1) * mLattice->width  +  i+1];

					if(c.attrs[end_cols] == 1){
						mLattice->buff1[j * mLattice->width + i].attrs[end_cols] = 1;
						continue;
					}
					
					Cell neighbourhood[8] = {nw, n, ne, w, e, sw, s, se};

					//2.1.1 transition rule
					psum = 0; //a0 = 0
					for(int col = 0; col < end_cols; col++){
						//psum in center cell
						psum += c.attrs[col] * weights[col];
					}
					psum = psum/100;
					p0 = exp(psum) / (1 + exp(psum));
					k = 1;
					//2.1.2 transition rule
					pn = 0;
					int nb = 3;
					//3 is neighbourhood size
					for (int h = 0; h < nb; h++){	
							pn += neighbourhood[h].attrs[end];
					}
			
					pn = pn / (nb*nb-1);
					//2.1.3 transition rule skipped (desnecessaria)
					//
					//2.1.4 transition rule
					pR = 1 + pow(-log(random()), k);

					p = p0 * pn * pR; //* pC(skipped rule)

					//printf("Cell[%d,%d]: psum: %.2f, p0: %.2f, pn: %.2f, pR: %.2f, p: %.2f", j, i, psum, p0, pn, pR, p);
	
					if(p > pThreshold)
						mLattice->buff1[j * mLattice->width + i].attrs[end_cols] = 1;
					else
						mLattice->buff1[j * mLattice->width + i].attrs[end_cols] = 0;
        }
    }
}

/*
 * Função para imprimir para arquivo. Formato do arquivo .txt
 */
void checkRuralAreas(tpLattice *mLattice)
{
	int totalUrbanAreas = 0;
  for (int i = 0; i < mLattice->height; i++){
		for(int j = 0; j < mLattice->width; j++){
      int k = j * mLattice->width + i;
			totalUrbanAreas += mLattice->buff0[k].attrs[end_cols] & 1;
		}
  }
	printf("\nFinal Urban Areas: %d\n", totalUrbanAreas);
}


double random()
{
    return (double)rand() / (double)RAND_MAX;
}
