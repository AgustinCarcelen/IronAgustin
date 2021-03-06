
import pandas as pd 
import numpy as np

#%matplotlib inline


######################################################################################################################
##################################       different methods to scale our numerical values        ######################
######################################################################################################################

def maxmin_scaler (X):
    from sklearn.preprocessing import MinMaxScaler
    df = MinMaxScaler().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def abs_scaler (X):
    from sklearn.preprocessing import MaxAbsScaler
    df = MaxAbsScaler().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def st_scaler (X):
    from sklearn.preprocessing import StandardScaler
    df = StandardScaler().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def rob_scaler (X):
    from sklearn.preprocessing import RobustScaler
    df = RobustScaler().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def nor_sclaer (X):
    from sklearn.preprocessing import Normalizer
    df = Normalizer().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def trans_sclaer (X):
    from sklearn.preprocessing import QuantileTransformer
    df = QuantileTransformer().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df


def pow_scaler (X):
    from sklearn.preprocessing import PowerTransformer
    df = PowerTransformer().fit(X).transform(X)
    df = pd.DataFrame(df, index=X.index, columns=X.columns)
    return df

######################################################################################################################
######################################################################################################################
######################################################################################################################



######################################################################################################################
################################       different methods to sample our numerical values        #######################
######################################################################################################################

def smote_sample(X,y):
    from imblearn.over_sampling import SMOTE 
    sampler = SMOTE()
    X_smote,y_smote = sampler.fit_resample(X,y)
    return X_smote,y_smote

def tomek_sample(X,y):
    from imblearn.under_sampling import TomekLinks 
    sampler= TomekLinks()
    X_tomek,y_tomek = sampler.fit_resample(X,y)
    return X_tomek,y_tomek

def randomunder_sample(X,y):
    from imblearn.under_sampling import RandomUnderSampler 
    sampler= RandomUnderSampler()
    X_rus,y_rus=sampler.fit_resample(X,y)
    return X_rus,y_rus

def randomover_sample(X,y):
    from imblearn.over_sampling import RandomOverSampler 
    sampler=RandomOverSampler()
    X_ros,y_ros=sampler.fit_resample(X,y)
    return X_ros,y_ros



######################################################################################################################
######################################################################################################################
######################################################################################################################



######################################################################################################################
#################################     different methods to train your model          #################################
######################################################################################################################

def logistic_regresion_train(X,y,control):
    from sklearn.model_selection import train_test_split 
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import accuracy_score 
    #split our data
    X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.30,random_state=40)
    #apply and train logistic regresion
    model=LogisticRegression(max_iter=500)
    model.fit(X_train,y_train)
    #calculate accuracy
    y_test_pred=model.predict(X_test)
    print("Accuracy of LogisticRegresion:",accuracy_score(y_test, y_test_pred))
    
    from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay
    import matplotlib.pyplot as plt 
    import seaborn as sns
    from sklearn.metrics import roc_auc_score, roc_curve
    #calculate confusion matrix and plot
    fig, (ax) = plt.subplots(3,1, figsize=(15, 20))
    cmx=confusion_matrix(y_test,y_test_pred)
    disp=ConfusionMatrixDisplay(confusion_matrix=cmx)
    disp.plot(ax=ax[0]);
    #confusion matrix heatmap
    sns.heatmap(cmx/np.sum(cmx), annot=True, fmt='.2%',cmap='Blues', ax=ax[1]);    
    #transform y_test from Yes/No to 1/0 it is necessary
    if control == True:
        def yes_no_to_0_1(x):
            if 'Yes' in x:
                return 1
            else: 
                return 0
        y_test = y_test.apply(yes_no_to_0_1)
    else:
        y_test = y_test
    
    y_pred_probs=model.predict_proba(X_test)[::,1]
    #roc_curve plot
    fpr,tpr, _ = roc_curve(y_test,y_pred_probs)
    auc=roc_auc_score(y_test,y_pred_probs)
    ax[2].plot(fpr,tpr,label='roc model,auc='+str(auc))
    ax[2].legend(loc=4)
    plt.show()
    

    return

######################################################################################################################
######################################################################################################################
######################################################################################################################



