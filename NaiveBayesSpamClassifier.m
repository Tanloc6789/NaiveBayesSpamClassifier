[final_ham_dict,final_spam_dict,final_train_dict,ham_ct,spam_ct]=create_dictionary();
cd ..
cd ..
[prob_ham_x,prob_spam_x,ham_ct,spam_ct]=TrainNB(final_ham_dict,final_spam_dict,final_train_dict,ham_ct,spam_ct);
dic_test=TestingNB(prob_ham_x,prob_spam_x,final_train_dict,ham_ct,spam_ct);
for i=1:length(dic_test)
v(i)=dic_test{2,i};
pv(i)=dic_test{5,i};
end
% compare predicted output with actual output from test data
cd ..
cd ..
confMat=myconfusionmat(v,pv);
disp('confusion matrix:')
disp(confMat)
conf=sum(pv==v)/length(pv);
disp(['accuracy = ',num2str(conf*100),'%'])
