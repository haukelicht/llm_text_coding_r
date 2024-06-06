# Pairwise comparisons of sentence pairs from Hargrave and Blumenau (2022)

author: Hauke Licht\
date: 2024-01-10

## Description

In the 2022 BJPolS paper "No Longer Conforming to Stereotypes? Gender, Political Style and Parliamentary Debate in the UK," Lotte Hargrave and Jack Blumenau analyze the rhetorical style of male and female MPs in the house of commons along eight dimensions:

- affective language
- positive emotions
- negative emotions
- factual language
- human narrative
- aggressive language
- complex language
- repetitiveness

Their measurements are mainly generated with a on word embedding-based text scaling appraoch.
But the collect a number of (pairwise) human judgments to validate their measurements.

## Annotation procedure

In the supporting materials, they describe their annotation procedure as follows:

> We wrote a web app which presented two research assistants with pairs of  sentences (sampled from all sentences in our corpus).
> Coders were asked to complete two tasks. 
> First, a *style-comparison task* required them to select which of the two sentences was more typical of a particular style. 
> Second, a *style-intensity task* required them to rate the degree to which each sentence was representative of the selected style on a  5 point scale.
> ...
> Each coder completed 70 comparisons per style, on average, meaning that we have on average 140 individual sentence-ratings per style.

Note that the authors also included 'minimal definitions of the speech-styles
of interest to ensure that the human coding related to the style dimensions 
identified in the literature review.'

- *affective language*: "Your task is to select the sentence which you believe uses more emotional language, which might be either positive or negative emotion; such as expressing criticism, praise, disapproval, pride, empathy or fear.",                       
- *positive emotions*: "Your task is to select the sentence which you believe uses more positive language, which might include expressing empathy, praise, pride, celebration or congratulations.",
- *negative emotions*: "Your task is to select the sentence which you believe uses more negative language, which might include expressing criticism, fear, unpleasantness, sadness or disapproval.",
- *factual language*: "Your task is to select the sentence which you believe uses more factual language, which might include the use of numbers, statistics, numerical quantifiers, figures and empirical evidence.",
- *human narrative*: "Your task is to select the sentence which you believe uses more human narrative, which might include referring to personal examples or experiences; the experiences and stories of other people; constituency stories; illustrative examples; drawing on human interest stories; or referring to individual people, including other Members of Parliament.",
- *aggressive language*: "Your task is to select the sentence which you believe uses more aggressive language, which might include criticisms or insults aimed at other MPs, people, groups, legislation, the government, parties or organizations; language that suggests forceful action; or confrontational, declamatory or adversarial language.",
- *complex language*: "Your task is to select the sentence which you believe uses more complex language, where complexity is defined as the use of elaborate and sophisticated language that is challenging to read and understand.",
- *repetitiveness*: "Your task is to select the sentence which you believe uses more repetitive language, where the sentence includes words and phrases that are used more than once."

These instructions can be regarded as prompts.

## The data

source: replication data on the BJPolS' harvard dataverse: https://doi.org/10.7910/DVN/PPSFLT, file 'validation_data.Rdata'

### Descriptives

Number of styles: 8
Number of coders: 2
Number of annotations by style:

- Affect: 183
- Aggression: 172
- Complexity: 172
- Fact: 174
- Human Narrative: 181
- Negative Emotion: 176
- Positive Emotion: 177
- Repetition: 199

Overall label distribution for pairwise comparisons ("style-comparison task"):

	 1 (sentence one more represetnative of STYLE): 554
	-1 (sentence two more represetnative of STYLE): 641
	 0 (both equally representative of STYLE, i.e. "tie"): 239

Label distribution for comparison taks by type

	                  first
	style_type         -1  0  1
	  Affect           60 37 86
	  Aggression       81 20 71
	  Complexity       97 19 56
	  Fact             85 28 61
	  Human Narrative  77 36 68
	  Negative Emotion 88 25 63
	  Positive Emotion 76 31 70
	  Repetition       77 43 79

Overall label distribution for sentence-level rating task ("style-intensity task"):

	sentence one
	0   1   2   3   4   5 
	1 370 331 297 254 181 

	sentence two
	0   1   2   3   4   5 
	1 318 319 297 288 211


Numbers of sentence pairs coded by both or only one coder:

	        style_type intercoder_samples both_coders one_coder
	1           Affect                 20          44        37
	2       Aggression                 20          39        44
	3       Complexity                 19          38        48
	4             Fact                 20          31        56
	5  Human Narrative                 19          57        24
	6 Negative Emotion                 20          18        89
	7 Positive Emotion                 20          38        56
	8       Repetition                 20          56        34

*Note:* 
The entries in column `intercoder_sample` are those that the authors have selected to assess intercoder reliability between the two (personal communication with Lotte Hargrave on 2023-12-21).
The other doubly-annotated sentence pairs are still valid, though!

Intercoder reliability (Krippendorff's alpha) by style computed in all double-annotated sentence pairs:

	style             pairwise   intensity
	Affect            0.619      0.565
	Aggression        0.526      0.528
	Complexity        0.852      0.748
	Fact              0.841      0.840
	Human Narrative   0.647      0.603
	Negative Emotion  0.743      0.674
	Positive Emotion  0.485      0.688
	Repetition        0.711      0.758

Number of valid sentence pairs and missingness rates (due to judgment disagreement) after aggregating (multiple) codings at sentence pair-level, by style

	                 n_valid prop_missing
	Affect                82       0.188 
	Aggression            86       0.165 
	Complexity            97       0.0762
	Fact                  98       0.0841
	Human Narrative       73       0.27  
	Negative Emotion     119       0.0630
	Positive Emotion      90       0.211 
	Repetition            89       0.191 


### Problems

- not all sentence pairse are multiply annotated (i.e. rated by by both coders)
- no native text pair IDs
- text pair IDs and text unit IDs generated by hashing sentences' texts show
	- 23 (of 826) text pairs coded for multiple types
	- 6 (of 820) `text1` units have been paired twice (none of them in the intercoder set)
	- 1 `text1` unit in `intercoder` set for one stlye but not another
	- 11 (of 815) `text1` unit have been paired twice (two of them in the intercoder set)
	- 4 `text2 units in `intercoder` set for one stlye but not another
	==> there are **almost no bridging observations** (would be required for Bradley-Terry scaling)
- when aggregating judgments into text-pair level labels, cannot find plurality judgment for 133 of 867 (~15%) of text pairs ==> for **734 text pairs** we have **valid (plurality) "comparison" labels**
	- missingness rates vary between styles (from 6% for "Negative Emotion" to 27% for "Human Narrative") ==> N ranges between 119 ("Negative Emotion") and 73 ("Human Narrative")
	- missingness is more severe for single-sentence ("intensity") judgment data (but could also just compute the median given that judgments are ordinal)
	- this leaves us with only **493 text pairs** (of 867) for which we have both a valid (plurality) "comparison" label and valid intensity scores for both texts