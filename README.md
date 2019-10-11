# CellTypeAnnotation_SC-RNA-seq
It aims to sketch the cell types of Single Cell RNA-seq data by annotating the most possible cell type to individual cell
## Usage
`#in general
cell_types<-AssignCellTypes(dataframe)

#for Seurat package
cell_types<-AssignCellTypes(object@assays$RNA@scale.data)
object$cell_types<-cell_types`

## Arguments
The dataframe is an expression matrix same as used in the Seurat package. To be specific, each row of the expression matrix represents a gene and each column represents a cell. If you are using the Seurat package, you may simplify use `object@assays$RNA@scale.data` or `object@assays$SCT@scale.data`. Also, make sure the row names of the dataframe are names of genes so that some of them can be matched with the signatures of cell types. 
## Details
To annotate the most possible cell type to individual cell:
1. Possible cell type names and their signatures should be provided. 
2. For each cell, their calculated scores represent the possibilities of being a particular cell type. Each score a sum of weight of highly expressed signatures whose expression level is higher than the average. In this way, each cell has several scores for possible cell types.
3. Pick the largest score in a cell and annotate the cell with the score-related cell type. Repeat it for every cell so that all cells annotated with their highest-score cell type.
