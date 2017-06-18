%First step : This file preprocesses the raw data with following
%preprocessing techniques :
%1.picking all files from the enron_dataset folder having two subfolders
%ham and spam.
%2.creating bag of words model using all the ham words and spam words,a
%cell array of strings called dic_ham and dic_spam.
%3.Removing Stop words,like "a","the","that","then",etc.
%4.Stemming and lemmaization for better accuracy and efficiency,words like
%played,playing are all rooted to "play",etc.
%5.Writing the words back to their files in two separate ham and spam
%folder,also create 10 fold cvpartition and creating test and train files.
[p f]=subdir('dataset_enron');
cd dataset_enron;
cd ham_trimmed;
clear('dic_ham');
for i=1:length(f{1}) % number of files in ham folder
    
    text=fileread(f{1}{i});
    text=regexprep(text,'[^a-zA-Z]',' '); %replace all special char except a-z A-Z with " "
    str=strsplit(text);
    dic_ham{i}=str;
end
cd ..;
cd spam_trimmed;
clear('dic_spam');
for i=1:length(f{2}) % number of files in spam folder
    
    text=fileread(f{2}{i});
    text=regexprep(text,'[^a-zA-Z]',' '); %replace all special char except a-z A-Z with " "
    str=strsplit(text);
    dic_spam{i}=str;
end

% tp=[dic_ham';dic_spam'];
% DICT=tp(randperm(length(tp)));

for i=1:length(dic_ham)
for j=1:length(dic_ham{i})
ham_dict{i,j}=dic_ham{i}{j};
end
end

for i=1:length(dic_spam)
for j=1:length(dic_spam{i})
spam_dict{i,j}=dic_spam{i}{j};
end
end

%stop words removal now
cd ..; %come out of dataset folder to the function folder
cd ..;
%stop words removal now
for i=1:length(dic_ham) 
    for j=1:length(dic_ham{i})
        ham_string=strjoin(dic_ham{i},' ');
        ham_string_wo_stop_words=stop_words_removal(ham_string);
        ham_wo_stop_words{i,:}=strsplit(ham_string_wo_stop_words);
    end
end

for i=1:length(dic_spam) 
    for j=1:length(dic_spam{i})
        spam_string=strjoin(dic_spam{i},' ');
        spam_string_wo_stop_words=stop_words_removal(spam_string);
        spam_wo_stop_words{i,:}=strsplit(spam_string_wo_stop_words);
    end
end


for i=1:length(ham_wo_stop_words)
    clear('ham_after_stem');
    for j=1:length(ham_wo_stop_words{i})
        ham_after_stem{j}=porterStemmer2(ham_wo_stop_words{i}{j});
    end
    FINAL_HAM{i}=ham_after_stem;
end
for i=1:length(spam_wo_stop_words)
    clear('spam_after_stem');
    for j=1:length(spam_wo_stop_words{i})
        spam_after_stem{j}=porterStemmer2(spam_wo_stop_words{i}{j});
    end
    FINAL_SPAM{i}=spam_after_stem;
end

%WRITE THESE PREPROCEESSED FILE TO TEXT FILES BACK
train=0.9*(length(FINAL_HAM)+length(FINAL_SPAM));
train=round(train)-1;
cd 'preprocessed_data'; 
cd ham;
for i=1:length(FINAL_HAM)
%     fname=sprintf('trainfile%d.txt',i);
    fid=fopen(f{1}{i},'w');
    fprintf(fid,'%s',strjoin(FINAL_HAM{i}));
    fclose(fid);
end
cd ..;
cd spam;
for i=1:length(FINAL_SPAM)
%     fname=sprintf('testfile%d.txt',i);
    fid=fopen(f{2}{i},'w');
    fprintf(fid,'%s',strjoin(FINAL_SPAM{i}));
    fclose(fid);
end

cd ..; 
for i=1:length(FINAL_HAM)
%     fname=sprintf('trainfile%d.txt',i);
    fid=fopen(f{1}{i},'w');
    fprintf(fid,'%s',strjoin(FINAL_HAM{i}));
    fclose(fid);
end
for i=1:length(FINAL_SPAM)
%     fname=sprintf('testfile%d.txt',i);
    fid=fopen(f{2}{i},'w');
    fprintf(fid,'%s',strjoin(FINAL_SPAM{i}));
    fclose(fid);
end
f1=f{1}(:);
f2=f{2}(:);
 tp=[f1;f2];
 fnames=tp(randperm(length(tp)));
 var=1;
for i=1:train
    movefile(fnames{var},'train_data');
    var=var+1;
end
for i=train+1:length(fnames)
    movefile(fnames{var},'test_data');
    var=var+1;
end
%=====================================
% for i=1:length(spam_dict_after_stem)
%     spam_dict_after_stem{i}=porterStemmer2(spam_dict_after_stem{i});
% end
% 
% for i=1:length(ham_dict_after_stem)
% ham_dict_after_stem{i}=porterStemmer2(ham_dict_after_stem{i});
% end
% %count occurances of word in dictionay
% nonrep_ham=unique(ham_dict_after_stem);
% nonrep_spam=unique(spam_dict_after_stem);
% %cell arrays having the occurance of each word
% occur_ham=cellfun(@(x) sum(ismember(ham_dict_after_stem,x)),nonrep_ham,'un',0);
% occur_spam=cellfun(@(x) sum(ismember(spam_dict_after_stem,x)),nonrep_spam,'un',0); 
% 
% final_ham_dict=cell(numel(occur_ham),2);
% final_spam_dict=cell(numel(occur_spam),2);
% 
% [sorted_occur_ham,index_occur_ham]=sort(cell2mat(occur_ham),'descend');
% [sorted_occur_spam,index_occur_spam]=sort(cell2mat(occur_spam),'descend');
% 
% final_ham_dict(:,1)=num2cell(sorted_occur_ham);
% final_ham_dict(:,2)=nonrep_ham(index_occur_ham);
% 
% final_spam_dict(:,1)=num2cell(sorted_occur_spam);
% final_spam_dict(:,2)=nonrep_spam(index_occur_spam);

