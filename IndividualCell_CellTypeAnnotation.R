# change the name of cell types and their signatures 
CellTypeNames<-c("cell_type_A","cell_type_B") # names of cell types
CellType<-data.frame(cell_type_A=c("signatureA1","signatureA2"),cell_type_B=c("signatureB1","signatureB2"))



AssignCellTypes<-function(dataframe){
  rownames<-rownames(dataframe)
  # initiate the score
  matrix_score<-array(c(rep(0,length(CellType)*ncol(dataframe))),
                      dim = c(length(CellType),ncol(dataframe)))
  listB<-c(1:ncol(dataframe))
  for (k in c(1:length(CellType))){
    listCellType<-setdiff(CellType[,k],rownames)
    l=length(listCellType)
    score = 1.1
    total_score=0
    for (i in 1:l){
      score = score-0.01 # here signatures are weighted differently 
      a<-match(listCellType[i],rownames) # find the location of that gene
      if (is.na(a)) {print("error")}
      else{
        a<-dataframe[a,] # find the expression values of that gene
        matrix_score[k,listB[a>mean(a)]]<-matrix_score[k,listB[a>mean(a)]]+score 
        total_score=total_score+score
      }
    }
    matrix_score[k,]<-matrix_score[k,]/total_score
  }
  rownames(matrix_score)<-CellTypeNames
  # assign cells to the largest score
  cellID_nearest<-c(rep(NA,ncol(dataframe)))
  # check ambiguous cells 
  same_score<-0
  cells<-c()
  for (i in c(1:ncol(dataframe))){
    a<-matrix_score[,i]
    if (length(a[a==max(a)])>1) {
      same_score<-same_score+1
      cells<-c(cells,i)
    }
    cellID_nearest[i]<-CellTypeNames[match(max(a),a)]
  }
  cat("there are",same_score," cells have two maximum scores and they can be assigned to one of the cell types with max scores.\n")
  return(cellID_nearest)
}


