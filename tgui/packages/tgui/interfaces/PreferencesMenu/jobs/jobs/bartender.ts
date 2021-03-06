import { Job } from "../base";
import { Service } from "../departments";

const Bartender: Job = {
  name: "Bartender",
  description: "Serve booze, mix drinks, keep the crew drunk.",
  department: Service,
  alt_titles: ["Bartender", "Mixologist"],
};

export default Bartender;
