%Second Step : This created the dictionary using the training data and also
%creates two other dictionary for spam and ham words in the total dataset.
%the three dictionary have the following format :
%words    no_of_occurances_of_that_word
function [final_ham_dict,final_spam_dict,final_train_dict,ham_ct,spam_ct]=create_dictionary()

[p f]=subdir('preprocessed_data');
cd preprocessed_data;
cd ham;
clear('dict1');
for i=1:length(f{1}) % number of files in ham folder
    
    text=fileread(f{1}{i});
    str=strsplit(text);
    dict1{i}=str;
end
cd ..;
cd spam;
clear('dict2');
for i=1:length(f{2}) % number of files in spam folder
    
    text=fileread(f{2}{i});
    str=strsplit(text);
    dict2{i}=str;
end
cd ..;
cd train_data;
clear('dict3');
%first calculate how may spam/ham messages are in training folder
ham_ct=0; spam_ct=0;
for i=1:length(f{4})
    idx=strfind(f{4}{i},'spam');
    if isempty(idx)
       ham_ct=ham_ct+1;
    else
        spam_ct=spam_ct+1;
    end
end

for i=1:length(f{4}) % number of files in train folder
    
    text=fileread(f{4}{i});
    str=strsplit(text);
    dict3{i}=str;
end
 tp=0;
for i=1:length(dict1)
for j=1:length(dict1{i})
ham_dict{tp+j}=dict1{i}{j};
end
tp=tp+length(dict1{i});
end

tp=0;
for i=1:length(dict2)
for j=1:length(dict2{i})
spam_dict{tp+j}=dict2{i}{j};
end
tp=tp+length(dict2{i});
end
tp=0;
for i=1:length(dict3)
for j=1:length(dict3{i})
train_dict{tp+j}=dict3{i}{j};
end
tp=tp+length(dict3{i});
end

%count occurances of word in dictionay
nonrep_ham=unique(ham_dict);
nonrep_spam=unique(spam_dict);
nonrep_train=unique(train_dict);

%cell arrays having the occurance of each word
occur_ham=cellfun(@(x) sum(ismember(ham_dict,x)),nonrep_ham,'un',0);
occur_spam=cellfun(@(x) sum(ismember(spam_dict,x)),nonrep_spam,'un',0); 
occur_train=cellfun(@(x) sum(ismember(spam_dict,x)),nonrep_train,'un',0); 

final_ham_dict=cell(numel(occur_ham),2);
final_spam_dict=cell(numel(occur_spam),2);
final_train_dict=cell(numel(occur_train),2);

[sorted_occur_ham,index_occur_ham]=sort(cell2mat(occur_ham),'descend');
[sorted_occur_spam,index_occur_spam]=sort(cell2mat(occur_spam),'descend');
[sorted_occur_train,index_occur_train]=sort(cell2mat(occur_train),'descend');

final_ham_dict(:,1)=num2cell(sorted_occur_ham);
final_ham_dict(:,2)=nonrep_ham(index_occur_ham);


final_spam_dict(:,1)=num2cell(sorted_occur_spam);
final_spam_dict(:,2)=nonrep_spam(index_occur_spam);

final_train_dict(:,1)=num2cell(sorted_occur_train);
final_train_dict(:,2)=nonrep_train(index_occur_train);

%now pass only top repeating words that will be part of dictionay
final_spam_dict=final_spam_dict(1:500,:);
final_ham_dict=final_ham_dict(1:500,:);
final_train_dict=final_train_dict(1:1000,:);
% BagOfWords=[final_ham_dict(:,2);final_spam_dict(:,2)];
% BagOfWords=unique(BagOfWords);