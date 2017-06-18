function dic_test=TestingNB(prob_ham_x,prob_spam_x,final_train_dict,ham_ct,spam_ct)
[p f]=subdir('preprocessed_data');
cd preprocessed_data;
cd test_data;
clear('dic_test');
%dic_test contains each cell of words of mail and 0 or 1 denoting spam or
%not,0 means not spam 1 means spam it will be used for testing purpose !
%format of dic_test: 
% row1 : cells containing test mail messages 
% row2 : values denoting actual classes of email messages,0 means not spam k 1 means spam
% row3 : ham score corresponding to each email message
% row4 : spam score corresponding to each email message
% row5 : predicted class values accorsing to ham and spam score
test_str=final_train_dict(:,2);
total_messages=length(f{1})+length(f{2});
%P(c)=no of messages of class c in trng data/no of total messages
%here class count is ham_ct/spam_ct and total count is total_messages
p_ham=double(ham_ct/total_messages);
p_spam=double(spam_ct/total_messages);
for i=1:length(f{3})
    text=fileread(f{3}{i});
    str=strsplit(text);
    dic_test{1,i}=str;
    if isempty(strfind(f{3}{i},'spam'))
        dic_test{2,i}=0;
    else
        dic_test{2,i}=1;
    end
end
% prob_ham=0;
% prob_spam=0;
% 
for i=1:length(dic_test)
    prob_ham=0;
    prob_spam=0;
    
for j=1:length(dic_test{1,i})
    index=find(strcmp(dic_test{1,i}{j},test_str));
   
    if ~(isempty(index))
       
         
%     prob_ham_x(index)
%     disp('index');
%   index
        prob_ham=prob_ham+log(prob_ham_x(index));
        prob_spam=prob_spam+log(prob_spam_x(index));
        
    end
end
dic_test{3,i}=prob_ham+log(p_ham);
dic_test{4,i}=prob_spam+log(p_spam);
if dic_test{3,i} > dic_test{4,i} % ham score is larger
    dic_test{5,i}=0; %not spam
else
    dic_test{5,i}=1; %spam
end
end


