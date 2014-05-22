function extract_features(scpdir,output_feat_dir,n_jobs,data_set)

% scpdir : contains wav.scp file, will store feats.scp file too
% output_feat_dir : where to store the features
% n_jobs : the number of jobs 
% dataset : train test or devel

if (~exist(output_feat_dir))
	mkdir (output_feat_dir);
end

wavfid = fopen([scpdir,'/wav.scp']);
featsfid = fopen([scpdir,'feats.scp'],'wt+');

bytes_offset = 0;

wavefilelist = textscan(wavfid, '%s', 'delimiter', '\n');
wavefilelist=wavefilelist{1};

all_fileids = strtok(wavefilelist,' ');
[fileids,fileidinds,fileinds] = unique(all_fileids);
n_files=length(fileids);

% splitting files as equally betwee the n_jobs
files_per_split = floor(n_files/n_jobs);
n_leftover = n_files - n_jobs*files_per_split;
files_in_split = files_per_split*ones(n_jobs,1);
for l=1:n_leftover
	files_in_split(l) = files_in_split(l)+1;
end

next_split_f = fileidinds(cumsum(files_in_split));
next_split_f = [1;next_split_f+1];

split = 0;
for f=1:n_files
	if f==next_split_f(split+1)
		split = split + 1;
		bytes_offset = 0;
		
		if split>1
			fclose(arkfid);
			fclose(featscpfid);
		end

		% open ark and scp files for writing
		arkfid = fopen([output_feat_dir,'raw_mfccs','.',num2str(split),'.ark'],'wt+');
		featscpfid = fopen([output_feat_dir,'raw_mfccs','.',num2str(split),'.scp'],'wt+');
		arkfilename = [output_feat_dir,'raw_mfccs','.',num2str(split),'.ark'];

	end

	% get the next line (uttid and filename)
	wavfile = wavefilelist{f};

	if (wavfile == -1)
		break;
	end

	% separate the utterance id and filename
        [uttid,filename]=strtok(wavfile,' ');
	
	% strip extra whitespace
        uttid = strtrim(uttid);
        filename = strtrim(filename);
	disp(uttid);

	% get the features with respect to this file
	command = ['./get_features_given_file ',uttid,' ',data_set,' temp'];
	system(command);
	feat = load('temp');
	feat = feat';

	n_elements=numel(feat);
    
        % print the features in the kaldi ark text format
        fprintf(arkfid,'%s ', uttid);

	% update the number of bytes for the feature scp file
        ark_struct=dir(arkfilename);
        arkbytes=ark_struct.bytes;

	% update the number of bytes written so far
        bytes_offset=arkbytes;


	fprintf(arkfid,'%s', ' [');
        fprintf(arkfid,['\n  ',repmat('%.15g ', 1, size(feat,1))],feat);
        fprintf(arkfid,'%s\n',']');

	% update feature scp files
        fprintf(featsfid,'%s\n',[uttid,' ',output_feat_dir,'raw_mfccs','.',num2str(split),'.ark:',num2str(bytes_offset)]);
        fprintf(featscpfid,'%s\n',[uttid,' ',output_feat_dir,'raw_mfccs','.',num2str(split),'.ark:',num2str(bytes_offset)]);

end

fclose(wavfid);
fclose(featsfid);
fclose(arkfid);
fclose(featscpfid);
 
