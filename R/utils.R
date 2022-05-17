#---------------------------------------------------
# log(a+b) = log(exp(a) + exp(b)) for nested sampling plots
#---------------------------------------------------
logsumexp <- function(aa, bb) {
  # Sum a and b via their logarithms, such that if:
  # a = log(x) and b = log(y)
  # logPlus(a, b) returns log(x + y)
  if (aa > bb) {
    ssum <- aa + log(1+exp(bb-aa))
  } else {
    ssum <- bb + log(1+exp(aa-bb))
  }
  return(ssum)
}

#---------------------------------------------------
# for a > b log(a-b) = log(exp(a) - exp(b))
#---------------------------------------------------
logdiffexp <- function(aa, bb) {

  if(aa > bb) {
    biggest <- aa
    a <- aa - biggest
    b <- bb - biggest
    ddif <- log(exp(a) - exp(b)) + biggest
  } else {
    # biggest <- bb
    # a <- aa - biggest
    # b <- bb - biggest
    # ddif <- log(exp(b) - exp(a)) + biggest
    stop("aa < bb !!!!!")
  }
  return(ddif)
}

#--------------------------------------------
#Remove the tabs put into a .net file saved from SamIam
#The tabs make loadHuginNet in gRain choke
#--------------------------------------------
remove.sam.tabs<-function(fpath){
  system(paste("expand -t2 ",fpath," > ",fpath,"_new",sep=""))
  system(paste("mv -f ",fpath,"_new"," ",fpath,sep=""))
}


#--------------------------------------------
#Set Prs of states for a Hugin CPT
#--------------------------------------------
mod.and.set.hugin.cpt<-function(hugin.domain, node.name, prob.vec, printQ=FALSE){

  #Get the CPT
  cp.table<-get.table(hugin.domain,node=node.name)

  #Complements to the prob.vec
  prob.vec.complement<-1-prob.vec

  #Interlace the two probability vectors together.
  total.prob.vec<-c(rbind(prob.vec,prob.vec.complement))
  #print(total.prob.vec)

  #Set the table back in Hugin
  cp.table[["Freq"]]<-total.prob.vec
  set.table(hugin.domain, node.name, cp.table)

  if(printQ==TRUE){
    print(paste("Changed CPT:",node.name))
    get.table(hugin.domain,node=node.name)
  }

}

#--------------------------------------------
#Merge (interlace) Prs with their complements to make a
#(gRain or Hugin) ordered prob vector for a CPT
#NOTE: ONLY FOR BINARY NODES!
#--------------------------------------------
merge.probs<-function(prob.vec){
  #Complements to the prob.vec
  prob.vec.complement<-1-prob.vec

  #Interlace the two probability vectors together.
  total.prob.vec<-c(rbind(prob.vec,prob.vec.complement))

  return(total.prob.vec)

}

#--------------------------------------------
#Test to see if a node is a prior node
#--------------------------------------------
gRain.prior.nodeQ<-function(gRain.CPT){

  table.depth <- length(dimnames(gRain.CPT))
  if(table.depth == 1){
    priorQ <- TRUE
  } else if(table.depth>1) {
    priorQ <- FALSE
  } else {
    priorQ <- NULL
  }

  return(priorQ)
}


#--------------------------------------------
#Convert a gRain format CPT to a Hugin format CPT
#gRain format is a (multi) table. Hugin format
#is a case-frequency data.frame
#NOTE: A gRain.CPT is just an array or parray
#--------------------------------------------
gRain2HuginCPT<-function(gRain.CPT, prior.nodeQ=NULL){

  if(is.null(prior.nodeQ)){
    print("******SPECIFY IF THIS IS A PRIOR NODE!!!!")
    return(0)
  }

  if(prior.nodeQ==TRUE){
    hug.cpt<-as.data.frame(gRain.CPT)

    #names(attributes( hug.cpt )$dimnames) <- names(attributes( gRain.CPT )$dimnames)
    #names(attributes( hug.cpt )$names) <- names(attributes( gRain.CPT )$dimnames)
    names(hug.cpt) <- names(attributes( gRain.CPT )$dimnames)
    #print(attributes(hug.cpt))

    colnames(hug.cpt)[1]<-paste("Freq", names(hug.cpt))
    return(hug.cpt)
  }

  if(prior.nodeQ==FALSE){
    return(as.data.frame(ftable(gRain.CPT)))
  }

}

#--------------------------------------------
#Convert a gRain format CPT to a Prettier formated CPT
#suitable for a human to easily read
#NOTE: A gRain.CPT is just an array or parray
#--------------------------------------------
gRain2PrettyCPT<-function(gRain.CPT, prior.nodeQ=NULL){

  if(is.null(prior.nodeQ)){
    print("******SPECIFY IF THIS IS A PRIOR NODE!!!!")
    return(0)
  }

  if(prior.nodeQ==TRUE){
    hug.cpt<-as.data.frame(gRain.CPT)

    #names(attributes( hug.cpt )$dimnames) <- names(attributes( gRain.CPT )$dimnames)
    #names(attributes( hug.cpt )$names) <- names(attributes( gRain.CPT )$dimnames)
    names(hug.cpt) <- names(attributes( gRain.CPT )$dimnames)
    node.name <- names(hug.cpt)
    #print(attributes(hug.cpt))

    #colnames(hug.cpt)[1]<-paste("Probability Value")
    #print(node.name)
    pr.sentence.strings <- paste("Pr(",node.name," = ", rownames(hug.cpt),")", sep="")
    #print(pr.sentence.strings)
    #print(hug.cpt)
    pretty.cpt <- data.frame(pr.sentence.strings,hug.cpt[,1])
    colnames(pretty.cpt)<-c("Event","Probability")
    rownames(pretty.cpt) <- 1:dim(pretty.cpt)[1]
    return(pretty.cpt)
    #return(hug.cpt)
  }

  if(prior.nodeQ==FALSE){
    #print(as.data.frame(ftable(gRain.CPT)))

    hug.cpt <- as.data.frame(ftable(gRain.CPT))
    node.name <- names(attributes( gRain.CPT )$dimnames)[1]

    parent.node.names <- names(attributes( gRain.CPT )$dimnames)[-1]

    pr.sentence.strings <- paste("Pr(",node.name," = ", hug.cpt[,1]," | ", sep="")
    #print(pr.sentence.strings)

    #Loop over each row, paste tog given statements, paste predicate into givens string
    #for(i in 1:dim(hug.cpt)[1]){
    #  #print(paste(hug.cpt[i, 2:(dim(hug.cpt)[2] - 1) ]))
    #}
    #Loop over CPT givens (parent node levels) columns

    srows <- NULL
    for(i in 2:(dim(hug.cpt)[2] - 1)){
      #If not end ,
      if(i !=(dim(hug.cpt)[2] - 1)) {
        srows <- cbind(srows, paste(parent.node.names[i-1], "=", hug.cpt[,i]), ", ")
      } else {
        srows <- cbind(srows, paste(parent.node.names[i-1], "=", hug.cpt[,i]))
      }
    }

    smat <- cbind(pr.sentence.strings, srows, rep(")", nrow(srows) ) )

    #print(dim(smat))
    pretty.cpt<-array("",c(nrow(smat),1))
    for(i in 1:nrow(smat)){

      tmp <- paste(as.vector(smat[i,]), sep="",collapse="")

      #tmp <- paste(as.vector(smat[i,]), " = ", sep="",collapse="")
      #tmp <- paste(tmp, " = ",hug.cpt[i,ncol(hug.cpt)])
      #print(tmp)
      pretty.cpt[i,] <- tmp

    }

    pretty.cpt <- data.frame(pretty.cpt, hug.cpt[,ncol(hug.cpt)])
    colnames(pretty.cpt) <- c("Event","Probability")

    return(pretty.cpt)

    #return(as.data.frame(ftable(gRain.CPT)))
  }

}


#--------------------------------------------
#A handy function to help print out gRain CPTs
#This will compile a CPT into the necessary
#parray form needed for gRain2HuginCPT. The
#trick is that the parent nodes and node names
#need to be included.
#EG: fool.compileCPT(list(bg.seeds, garnet, loc), c("bg.seeds","garnet", "loc"))[[1]]
#spits out the parray for bg.seeds. bg.seeds has parent nodes garnet and loc
#--------------------------------------------
fool.compileCPT<-function(vpar.list, node.names){

  #print(vpar.list)

  all.node.list<-rep(list(NULL), length(vpar.list))
  #print(vpar.list)

  all.node.list[[1]]<-vpar.list[[1]]
  all.node.list[[1]]$vpa<-node.names

  for(i in 2:length(vpar.list)){
    all.node.list[[i]]<-vpar.list[[i]]
    #Below for fooling compileCPT into thinking the the parent nodes have no parents.
    #all.node.list[[i]]$vpa <- all.node.list[[i]]$vpa[1]
    all.node.list[[i]]$vpa <- node.names[i]
    all.node.list[[i]]$values<-rep(1,length(all.node.list[[i]]$levels  ) )

    #print(all.node.list)
    #print("______________")

  }
  #print(all.node.list)

  cl<-compileCPT(all.node.list)

  return(cl)

}

#--------------------------------------------
#Initialize a grain CPT
#NOTE: All parent nodes MUST be previously defined.
#For the defn of vpar.list cf. help page of cptable.
#--------------------------------------------
initialize.gRainCPT<-function(vpar.list, child.node.levels=NULL, printQ=FALSE) {

  #Through error if no states are given for child node:
  if(is.null(child.node.levels)){
    print("Specify child node levels!")
    return(0)
  }

  #Check to see if this is going to be a prior node
  if(length(vpar.list)==1){
    prior.nodeQ<-TRUE
  } else {
    prior.nodeQ<-FALSE
  }

  #Set up node names to send to cptable in gRain:
  if(prior.nodeQ==FALSE){

    pa.node.names<-sapply(2:length(vpar.list),function(x){vpar.list[[x]]$vpa[1]})
    #print(pa.node.names)

    ch.node.name<-vpar.list[[1]]
    node.names<-c(ch.node.name, pa.node.names)
  } else {
    ch.node.name<-vpar.list[[1]]
    node.names<-c(ch.node.name)
  }

  #Compute the number if 1s required to fill the CPT:
  num.probs<-length(child.node.levels)
  if(prior.nodeQ==FALSE){
    for(i in 2:length(vpar.list)){
      num.probs<- num.probs * length(vpar.list[[i]]$levels)
    }
  }

  #Get the CPT:
  node.cpt<-cptable(node.names, values=rep(1,num.probs), levels=child.node.levels, normalize=F)

  #Print the CPT if desired:
  if(printQ==TRUE){
    all.node.list<-rep(list(NULL), length(vpar.list))

    all.node.list[[1]]<-node.cpt
    if(prior.nodeQ==FALSE){
      for(i in 2:length(vpar.list)){
        all.node.list[[i]]<-vpar.list[[i]]
        #Below for fooling compileCPT into thinking the the parent nodes have no parents.
        all.node.list[[i]]$vpa<-all.node.list[[i]]$vpa[1]
        all.node.list[[i]]$values<-rep(1,length(all.node.list[[i]]$levels  ) )
        #print(all.node.list)
        #print("______________")
      }
    }
    print("-----------------")
    print(paste("Initialized node:  ",vpar.list[[1]]))
    print("-----------------")
    print(gRain2HuginCPT(compileCPT( all.node.list)[[1]], prior.nodeQ))
  }

  return(node.cpt)
}

#--------------------------------------------
#Set the Prs in an initialized a grain CPT
#--------------------------------------------
#****BROKEN????????
# set.gRainCPT<-function(node.cpt, prob.vec, complement.prob.vecQ=FALSE){
#
#   total.prob.vec<-prob.vec
#   if(complement.prob.vecQ==TRUE){
#     #Complements to the prob.vec
#     total.prob.vec<-merge.probs(prob.vec)
#   }
#
#   #Set the probabilities in the node:
#   new.node.cpt<-node.cpt
#   new.node.cpt$values<-total.prob.vec
#
#   return(new.node.cpt)
#
# }
#Set the Prs in an initialized a grain CPT
set.gRainCPT<-function(node.cpt, prob.vec, complement.prob.vecQ=FALSE){

  total.prob.vec<-prob.vec
  if(complement.prob.vecQ==TRUE){
    #Complements to the prob.vec
    total.prob.vec<-merge.probs(prob.vec)
  }

  #Set the probabilities in the node:
  new.node.cpt<-node.cpt
  new.node.cpt[] <- total.prob.vec #Should work the same for prior and conditional nodes.

  #   if(gRain.prior.nodeQ(node.cpt) == TRUE){
  #
  #     new.node.cpt[] <- total.prob.vec
  #
  #   } else if(gRain.prior.nodeQ(node.cpt) == FALSE) {
  #
  #     new.node.cpt[] <- total.prob.vec
  #   }

  return(new.node.cpt)

}


#--------------------------------------------
#Get a gRain CPT from a gRain network
#node.name is text of the desired node's name
#--------------------------------------------
get.gRainCPT<-function(gRain.domain, node.name) {

  node.idx <- which(nodeNames(gRain.domain) == node.name)
  node.table <- gRain.domain$cptlist[[node.idx]]
  #print(node.table)

  return(node.table)
}


#--------------------------------------------
#Henrion style Noisy-OR gate
#Handy for nodes with more than two parents
#
#NOTE: This ONLY generates the noisy-or probs
#for the table, NOT the table itself
#
#NOTE ALSO: For binary nodes with binary parents only
#--------------------------------------------
noisy.or.probs<-function(gRain.CPT, cond.parent.yes.probs.vec, leak.prob, complementQ=TRUE){

  #These are the "yeses" or "trues" of the parent nodes.
  parent.yes.levels<-data.frame(attributes(gRain.CPT)$dimnames, stringsAsFactors=F)[1,-1]
  #print(parent.yes.levels)

  #Convert the CPT over to Hugin format for an easier read
  hug.cpt<-gRain2HuginCPT(gRain.CPT, prior.node=F)
  #Drop the first and last columns
  hug.cpt<-hug.cpt[,-c(1,ncol(hug.cpt))]

  #Get the "yes" indices of the CPT: 1,3,5,7,....
  top.idxs<-seq(1, nrow(hug.cpt), 2)

  prob.vec<-rep(-1,length(top.idxs))
  count<-1
  for(i in top.idxs){
    #Compare to see if any of the causes are "on" for the row in the CPT
    yes.idxs<-which((parent.yes.levels == hug.cpt[i,])==TRUE )

    if(length(yes.idxs)==0){  #If none of the causes are "on" fill in the leak probability
      prob.vec[count] <- leak.prob
      count <- count + 1
    } else {                  #Otherwise use Henrion's formula for combining the ps of those causes that are "on"
      prob.vec[count] <- 1 - ( (1-leak.prob) * prod((1-cond.parent.yes.probs.vec[yes.idxs])/(1-leak.prob)) )
      count <- count + 1
    }

  }

  if(complementQ==TRUE){
    prob.vec.total<-merge.probs(prob.vec)
  } else {
    prob.vec.total<-prob.vec
  }


  return(prob.vec.total)



}

#--------------------------------------------
#Get the index of a specified state probability
#in a gRain CPT.
#nslist is the variable specification list. They can
#be specified in any order.
#NOTE: A gRain.CPT is just an array or parray
#--------------------------------------------
gRain.pr.index<-function(gRain.CPT, prior.nodeQ=NULL, nslist=NULL){


  if(is.null(prior.nodeQ)){
    print("******SPECIFY IF THIS IS A PRIOR NODE!!!!")
    return(0)
  }

  if(prior.nodeQ==TRUE){
    row.idx <- which(names(gRain.CPT) == nslist[[1]])
    if(length(row.idx) == 0) {
      stop("Probability not found in node table!")
    }
  }

  if(prior.nodeQ==FALSE){

    #Convert the CPT into Hugin form (linear)
    hug.cpt <- as.data.frame(ftable(gRain.CPT))
    node.name <- names(attributes( gRain.CPT )$dimnames)[1]
    parent.node.names <- names(attributes( gRain.CPT )$dimnames)[-1]

    #Pick out the row number of the Hugin CPT which contains the the requested probability, according to nslist
    row.idx.list <- rep(list(NULL),length(nslist))
    for(i in 1:length(nslist)){
      node.idx <- which(colnames(hug.cpt) == names(nslist)[i] )
      row.idx.list[[i]] <- which(hug.cpt[,node.idx] == nslist[[i]] )

    }
    row.idx <- Reduce('intersect', row.idx.list)

#     if(length(row.idx) == 0) {                #Not needed. Case should kill the function on line: row.idx.list[[i]] <- which(hug.cpt[,node.idx] == nslist[[i]] )
#       stop("Probability not found in CPT!")
#     }


  }

  return(row.idx)

}


#--------------------------------------------
#Get the index of a specified state probability
#in a pretty formatted hugin CPT.
#pretty.hugin.ns.specification is the probability specification.
#It is a text string e.g.: Pr(Monty_Chooses = Door3 | Prize = Door3, You_Choose = Door1)
#This function is primarily intended to be used internally
#with the shiny bayes net gui
#--------------------------------------------
pretty.hugin.pr.index<-function(pretty.hugin.CPT, pretty.hugin.ns.specification){

  #Get all the pretty formated node states from the Hugin CPT
  pretty.ns <- as.character(pretty.hugin.CPT[,1])

  #Which one (row number of the CPT) corresponds to the requested probability:
  row.idx <- which(pretty.ns == pretty.hugin.ns.specification)

  return(row.idx)
}
