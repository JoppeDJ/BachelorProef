function batch = strat_sample(data, sample_size)

idx = 1;
while data(3,idx) == 1
    idx = idx + 1;
end

data_A = data(:,1:idx-1);
data_B = data(:,idx:end);

ab_ratio = size(data_A,2)/size(data,2);

samplesize_a = fix(sample_size*ab_ratio);
samplesize_b = sample_size - samplesize_a;

datasample_a = datasample(data_A,samplesize_a,2,'Replace',false);
datasample_b =datasample(data_B,samplesize_b,2,'Replace',false);
batch = [datasample_a datasample_b];
