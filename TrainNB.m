
function [prob_ham_x,prob_spam_x,ham_ct,spam_ct]=TrainNB(final_ham_dict,final_spam_dict,final_train_dict,ham_ct,spam_ct) %give probablity of spam and ham according to bag of words dictionary
ham_dict_len=length(final_ham_dict);
spam_dict_len=length(final_spam_dict);
total_dict_len=length(final_train_dict);
ham_string=final_ham_dict(:,2);
spam_string=final_spam_dict(:,2);
for i=1:total_dict_len
%     if isempty(final_train_dict{i})
%         continue;
%     end
%we will be using here laplacian additive smoothig to take care the case of
%zero probability. 
%P(w|c)=count of word w in class c/count of words in class c
%P(w|c)=count(w,c)+1/count(c)+|V|+1 this is laplace additive
%smoothing,where |v| is no of words in training set,here total_dict_len
    index1=find(strcmp(final_train_dict{i,2},ham_string));
    index2=find(strcmp(final_train_dict{i,2},spam_string));
    if isempty(index1) 
        prob_ham_x(i)=double(1/(total_dict_len+ham_dict_len+1));
    else
        tmp=final_ham_dict{index1};
        prob_ham_x(i)=double(tmp+1/total_dict_len+ham_dict_len+1);
    end
    
    if isempty(index2)
        prob_spam_x(i)=double(1/(total_dict_len+spam_dict_len+1));
    else
        tmp2=final_spam_dict{index2};
        prob_spam_x(i)=double(tmp2+1/total_dict_len+spam_dict_len+1);
    end
end


        
    