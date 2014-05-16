#!/usr/bin/perl

use strict;

# get binary predictions (first dim: score, second dim: 0/1 for negative / positive instance)
sub parse_predictions {
    my $ref_arff = shift;
    my $pred_arff = shift;
    my $pred_ref = shift;
    my $class_idx = shift;
    my $class_name = shift;
    my $i = 0;
    my $data = 0;
    # TODO: verify instance names (frame index)
    open(PRED, "<$pred_arff") or die "$pred_arff: $!";
    while(<PRED>) {
        chomp;
        if (/\@data/) {
            $data = 1;
        }
        elsif ($data && !/^\s*$/) {
            my @els = split(/,/);
            my @scores = @els[$#els-2..$#els];
            my $score = $scores[$class_idx - 1];
            $pred_ref->[$i][0] = $score;
            ++$i;
        }
    }
    close(PRED);
    open(REF, "<$ref_arff") or die "$ref_arff: $!";
    my $data = 0;
    my $i2 = 0;
    while (<REF>) {
        chomp;
        if (/\@data/) {
            $data = 1;
        }
        elsif ($data && !/^\s*$/) {
            my @els = split(/,/);
            #print "pred = $els[$#els]\n";
            my $corr = $els[$#els] eq $class_name ? 1 : 0;
            $pred_ref->[$i2][1] = $corr;
            #print "corr[$i] = $corr\n";
            ++$i2;
            #last if ($i == 10);
        }
    }
    if ($i != $i2) {
        print "ERROR: Mismatched number of predictions ($i2) and ground truth labels ($i)!\n";
        exit 1;
    }
    close(REF);
}

sub score_arr_det {
  # compute detection scores
  # 1. quicksort of (predictions, groundtruth) 
  # 2. top-down P(det/fa) computation
  my @psort = sort {$b->[0] <=> $a->[0]} @{$_[0]};

  # get overall stats
  my $Npos = 0;
  my $Nneg = 0;
  for (my $i = 0; $i <= $#psort; $i++) {
    if ($psort[$i][1] > 0.5) { $Npos++; }
    else { $Nneg++; }
  }
 
  # go through list once
  my $auc = 0;
  my $eer = 0;
  my $eer_thresh = -1;
  my $roc_res_fa = 0.01;
  my @roc;
  $roc[0]{"Pd"} = 0.0;
  $roc[0]{"Pfa"} = 0.0;
  $roc[0]{"Pfa_approx"} = 0.0;
  $roc[0]{"threshold"} = 1.0;
  my $roc_ptr = 0;
  my $Nfp_top = 0;
  my $Ntp_top = 0;
  my $prev_Pfa = 0;
  my $prev_Pd = 0;
  my $max_A = 0;
  my $pd_max_A = 0;
  my $pf_max_A = 0;
  my $max_A_thresh = -1;
  for (my $i = 0; $i <= $#psort; $i++) {
    #print "score = $psort[$i][0], gt = $psort[$i][1]\n";
    if ($psort[$i][1] > 0.5) { $Ntp_top++; }  # true positives
    else { $Nfp_top++; }  # false positives
    my $Pfa = -1.0;
    if ($Nneg > 0) {
      $Pfa = $Nfp_top / $Nneg;
    }
    my $Pd =  -1.0;
    if ($Npos > 0) {
      $Pd = $Ntp_top / $Npos;
    }
    my $Pfa_de = $Pfa - $prev_Pfa;
    my $A = $Pfa_de * $prev_Pd;
    $auc += $A;
    $prev_Pd = $Pd;
    $prev_Pfa = $Pfa;
    my $Pfr = 1.0 - $Pd;  # false rejection prob.
    if ($i > 1 && $Pfa > $Pfr && $eer == 0) {
      $eer = $Pfa;
      $eer_thresh = $psort[$i][0]; 
    }
    #last if ($i == 100);
  }
  return ($auc, $eer, $eer_thresh);
}

if ($#ARGV < 1) {
    print "Usage: $0 <ref_file> <pred_file>\n";
    exit -1;
}

my @classes = (2, 3);
my @class_names = ("laughter", "filler");
for my $i (0..$#classes) {
    my @pred;
    parse_predictions($ARGV[0], $ARGV[1], \@pred, $classes[$i], $class_names[$i]); 
    my ($auc, $eer) = score_arr_det(\@pred);
    print "Class: $class_names[$i]\n";
    print "AUC = ", sprintf("%f", $auc * 100), "%\n";
    print "EER = ", sprintf("%f", $eer * 100), "%\n";
}
