#include <stdio.h>
#include <math.h>

/*
Updated: July 2021
Yi Zhu, yi.zhu@berkeley.edu
*/

// max value of 16-bit short
#define SHORT_MAX 32767
#define TP 2*M_PI

/*
Generates a saw wave at sample rate.

t:  wave time in sec
sr: sample rate in samples/sec
p:  pointer to allocated buffer; data is generated to buffer in place
*/
void saw(double t, double sr, short* p) {
	int n = (int)(t*sr);
	int i;
	for(i=0; i<n; i=i+1) {
		p[i] = i%(2*SHORT_MAX);
	}
}

/*
Sine wave at the given frequency.
*/
void exact_tone(double t, double sr, double f, short* p) {
	int n = (int)(t*sr);
	int i;
	for(i=0; i<n; i=i+1) {
		p[i] = SHORT_MAX * sin(TP*f*i/sr);
	}	
}

/*
Add sin wave to existing buffer.

start: start time (s)
end: end time (s)
sr = sample rate
f = frequency
samples: number of samples that for a segment to be looped
factor: scaling factor to multiply the wave
channel: -1 if single channel, or specify channel 0 or 1 if both channels are in use
p: buffer

*/
void add_sin(double start, double end, double sr, double f, int samples, double factor, int channel, short*p) {
	int n = (int)((end-start)*sr);
	int start_index = (int)(start*sr);
	
	int cycles = round(f/sr*samples);
	// printf("cycles %d\n", cycles);

	double actual = cycles*sr/samples;
	// printf("actual f %f\n", actual);

	int full = n/samples;
	int partial = n%samples;
	// printf("%d\n", full);
	// printf("%d\n", partial);

	short seg[samples];
	int i;
	int j;

	for(i=0; i<samples; i++) {
			seg[i] = factor * SHORT_MAX * sin(TP*actual*i/sr);
	}

	// there is a single channel, fill the buffer normally
	if (channel==-1) {
		for(i=0; i<full; i++) {
			int offset = start_index + i*samples;
			for(j=0; j<samples; j++) {
				p[offset+j] += seg[j];
			}
		}
		int offset = start_index + full*samples;
		for (i=0; i<partial; i++) {
			p[offset+i] += seg[i];
		}
	}
	else if (channel==0) { // both channels active, fill channel 0 positions
		for(i=0; i<full; i++) {
			int offset = start_index + i*samples;
			for(j=0; j<samples; j++) {
				p[2*(offset+j)] += seg[j];
			}
		}
		int offset = start_index + full*samples;
		for (i=0; i<partial; i++) {
			p[2*(offset+i)] += seg[i];
		}	
	}
	else if (channel==1) { // both channels active, fill channel 1 positions
		for(i=0; i<full; i++) {
			int offset = start_index + i*samples;
			for(j=0; j<samples; j++) {
				p[2*(offset+j)+1] += seg[j];
			}
		}
		int offset = start_index + full*samples;
		for (i=0; i<partial; i++) {
			p[2*(offset+i)+1] += seg[i];
		}	
	}
	
}

/*
Fills the buffer with zeros during the specified times
*/
void fill_zero(double start, double end, double sr, short*p) {
	int start_index = (int)(start*sr);
	int end_index = (int)(end*sr);

	int i;
	for(i=start_index; i<end_index; i++) {
		p[i] = 0;
	}
}

/*
Structure of a pulse sequence: [f1, start1, end1, factor1,  
								f2, start2, ...]

t: time of pulse
sr: samplerate
n0: number of frequencies in the channel 0 pulse sequence
n1: number of freqs. in channel 1
ps0: pulse sequence frequencies for channel 0. Nulf if channel 0 should output no pulse sequence
ps1: pulse sequence freqs. for channel 1
samples: number of samples looped segment

*/

void gen_ps(double t, double sr, int n0, int n1, double* ps0, double* ps1, int samples, short*p) {
	// no ps to generate
	if(ps0==NULL && ps1==NULL) {
		return;
	}

	int channel;

	// only channel 1
	if (ps0==NULL){
		fill_zero(0, t, sr, p);
		int i;
		int offset = 0;
		for(i=0; i<n1; i++) {
			add_sin(ps1[offset+1], ps1[offset+2], sr, ps1[offset], samples, ps1[offset+3], -1, p);
			offset += 4;
		}
	}// only channel 0
	else if (ps1==NULL){
		fill_zero(0, t, sr, p);
		int i;
		int offset = 0;
		for(i=0; i<n0; i++) {
			add_sin(ps0[offset+1], ps0[offset+2], sr, ps0[offset], samples, ps0[offset+3], -1, p);
			offset += 4;
		}
	}// both channels
	else {
		fill_zero(0, 2*t, sr, p); // double time because we need two channels worth of zero
		int i;
		int offset = 0;
		for(i=0; i<n0; i++) {
			add_sin(ps0[offset+1], ps0[offset+2], sr, ps0[offset], samples, ps0[offset+3], 0, p);
			offset += 4;
		}
		offset = 0;
		for(i=0; i<n1; i++) {
			add_sin(ps1[offset+1], ps1[offset+2], sr, ps1[offset], samples, ps1[offset+3], 1, p);
			offset += 4;
		}
	}
	
}

int main() {}
