#!/data/sbcs/bin/python

import sys, os
import argparse
import subprocess

class ZCaller(object):
	def __init__(self):
		self.gs_reports = []
		self.temp_dir = ""
		self.output_dir = ""
		self.zcall_dir = "zcall"
		self.weighted_lr = 0
		self.min_intensity = 0.2
		self.z_score = 7

	def Init(self):
		cwd = os.path.abspath(os.getcwd())
		parser = argparse.ArgumentParser(description='zCall wrapper')
		parser.add_argument('gs_reports', metavar='filename', nargs="+",
			help="One or more GenomeStudio reports")
		parser.add_argument('--output-dir', metavar='directory', 
			default="%s/zcalls" % (cwd))
		parser.add_argument("--intermed-dir", metavar="directory",
			default="%s/zcall_temp" % (cwd))
		parser.add_argument("--zcall-dir", metavar="directory",
			default=self.zcall_dir)
		parser.add_argument("--use-weighted-lr", action="store_true", default=False)
		parser.add_argument("--min-int", default=0.02, type=float, 
			help="Minimum intensity to be passed to findThresholds.py")
		parser.add_argument("--z-score", default=7, type=int, 
			help="z-score threshold to be passed to findThresholds.py")
	
		args = parser.parse_args()
		self.gs_reports = args.gs_reports
	
		self.output_dir = args.output_dir
		try:
			os.makedirs(self.output_dir)
		except:
			pass
		
		self.temp_dir  = args.intermed_dir
		try:
			os.makedirs(self.temp_dir)
		except:
			pass

		self.zcall_dir = args.zcall_dir
		self.min_intensity = args.min_int
		self.z_score = args.z_score
		if args.use_weighted_lr:
			self.weighted_lr = 1

	def System(self, cmd):
		print cmd
		proc = subprocess.Popen(cmd, shell=True,
				stdout=subprocess.PIPE)
		print  proc.stdout.read()


	def Run(self):
		for filename in self.gs_reports:
			report_prefix = "%s/%s" % (self.temp_dir, os.path.basename(filename))
			meansd_filename    = "%s.meansd" % (report_prefix)
			betas_filename     = "%s.betas" % (report_prefix)
			threshold_filename = "%s.threshold" % (report_prefix)
			concordance_filename = "%s.concordance" % (report_prefix)
			self.System("python %s/findMeanSD.py -R %s > %s" % (self.zcall_dir, 
					filename, meansd_filename))
			self.System("Rscript %s/findBetas.r %s %s %s" % (self.zcall_dir,
					meansd_filename, betas_filename, self.weighted_lr))
			self.System("python %s/findThresholds.py -B %s -R %s -I %s -Z %s > %s" % (
					self.zcall_dir, betas_filename, filename, 
					self.min_intensity, self.z_score,
					threshold_filename
					))
			self.System("python %s/zCall.py -R %s -T %s -O %s/%s" % (
					self.zcall_dir, filename, threshold_filename,
					self.output_dir, os.path.basename(filename)))
			self.System("python %s/calibrateZ.py -R %s -T %s > %s" %
				(self.zcall_dir, filename,
				threshold_filename,
				concordance_filename))
					
if __name__ == "__main__":
	zc = ZCaller()
	zc.Init()
	zc.Run()
				
