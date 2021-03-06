import { Job } from "../base";
import { Medical } from "../departments";

const Psychologist: Job = {
  name: "Psychologist",
  description: "Advocate sanity, self-esteem, and teamwork in a station \
    staffed with headcases.",
  department: Medical,
  alt_titles: ["Psychologist", "Psychiatrist", "Therapist", "Counsellor"],
};

export default Psychologist;
